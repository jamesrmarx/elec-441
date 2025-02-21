% <strong>kalman</strong> - Kalman Decomposition
%   This function returns the Kalman Decomposition of a state space model.
%
%   Additional computations are made in an attempt to closer match an
%   answer which would be computed by hand - such as keeping basis vectors
%   positive and not defaulting to normalized vectors
%
%   Syntax
%   kd = <strong>kalman</strong>(A,B,C)
%
%   Input Arguments
%   <strong>A</strong> - State matrix
%   <strong>B</strong> - Input matrix
%   <strong>C</strong> - Output matrix
%
%   Output Arguments
%   <strong>kd.A</strong> - Coordinate transformed state matrix
%   <strong>kd.B</strong> - Coordinate transformed input matrix
%   <strong>kd.C</strong> - Coordinate transformed output matrix
%   <strong>kd.T_inv</strong> - Coordinate transform matrix
%   <strong>kd.z_dim</strong> - Array for dimension of transformed state variables
%   [zco    zc_o    z_co    z_c_o]
%   zco   - controllable and observable
%   zc_o  - controllable and not observable
%   z_co  - not controllable and observable
%   z_c_o - not controllable and not observable
function KD = kalman(A,B,C)
    Cb = ctrb(A,B);
    Ob = obsv(A,C);

    % find basis for Image Space of Cb
    [R, pivot_cols] = rref(Cb);
    basis_Im = R(:,pivot_cols);
    basis_Im_comp = null(basis_Im');

    % find basis for Kernel Space of Ob 
    basis_Ker = null(Ob);
    basis_Ker = normalizeOne(basis_Ker);
    basis_Ker_comp = normalizeOne(null(basis_Ker'));

    % find bases for coordinate transform matrix subspaces
    Tc_o = intersection_basis(basis_Im, basis_Ker);
    T_co = intersection_basis(basis_Im_comp, basis_Ker_comp);
    T_c_o = intersection_basis(basis_Im_comp, basis_Ker);
    Tco = intersection_basis(basis_Im, basis_Ker_comp);
    
    T_inv = [Tco, Tc_o, T_co, T_c_o];
    
    KD.A = T_inv\A*T_inv;
    KD.B = T_inv\B;
    KD.C = C*T_inv;
    KD.T_inv = T_inv;
    KD.z_dim = [size(Tco,2), size(Tc_o,2), size(T_co,2), size(T_c_o,2)];
end

% Computes a basis for the intersection of two subspaces
function B = intersection_basis(A, B)
    N = null([A, -B]);
    if (~isempty(N))
        N = normalizeOne(N);
        B = A * N(1:size(A,2), :);
        % Ensure the basis vectors are positive (if possible)
        positiveBasis = B;
        for i = 1:size(positiveBasis, 2)
            % If the first non-zero element is negative, flip the sign of the vector
            if any(positiveBasis(:, i) < 0)
                positiveBasis(:, i) = -positiveBasis(:, i);
            end
        end
        B = positiveBasis;
    else
        B = [];
    end
end

% normalize smallest value to 1 - keeping signs
function normA = normalizeOne(A)
    nonZeroElements = A(A ~= 0); % Extract non-zero elements
    smallestNonZero = min(nonZeroElements); % Find the smallest non-zero element
    normA = A / abs(smallestNonZero);
end