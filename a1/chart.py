import numpy as np
import matplotlib.pyplot as plt
from PIL import Image
from matplotlib.widgets import Slider, Button
import tkinter as tk
from tkinter import filedialog

# Smith Chart Transformation
def smith_chart_transform(z):
    return (z - 1) / (z + 1)

# Function to load image using file dialog
def load_image():
    root = tk.Tk()
    root.withdraw()  # Hide the root window
    # Open file dialog and filter for image files
    file_path = filedialog.askopenfilename(
        title="Select an Image",
        filetypes=[("Image files", "*.png;*.jpg;*.jpeg;*.bmp;*.tiff")]
    )
    if file_path:
        try:
            return Image.open(file_path).convert('RGBA')
        except Exception as e:
            print(f"Error loading image: {e}")
            return None
    return None

# Load the image using file dialog
image = load_image()
if image is None:
    print("No image selected or failed to load. Exiting.")
    exit()

# Create the figure and axis
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(12, 6))
plt.subplots_adjust(left=0.1, bottom=0.35)

# Display the original image on the impedance plane
ax1.set_title('Impedance Plane')
ax1.imshow(image, extent=[-1, 1, -1, 1])

# Display the Smith chart
ax2.set_title('Smith Chart')
ax2.set_xlim(-1, 1)
ax2.set_ylim(-1, 1)
ax2.grid(True)

# Initial position and scale
init_scale = 1.0
init_x = 0.0
init_y = 0.0

# Create sliders for scaling and positioning
axcolor = 'lightgoldenrodyellow'
ax_scale = plt.axes([0.2, 0.1, 0.65, 0.03], facecolor=axcolor)
ax_x = plt.axes([0.2, 0.15, 0.65, 0.03], facecolor=axcolor)
ax_y = plt.axes([0.2, 0.2, 0.65, 0.03], facecolor=axcolor)

scale_slider = Slider(ax_scale, 'Scale', 0.1, 2.0, valinit=init_scale)
x_slider = Slider(ax_x, 'X Position', -1.0, 1.0, valinit=init_x)
y_slider = Slider(ax_y, 'Y Position', -1.0, 1.0, valinit=init_y)

# Update function for the sliders
def update(val):
    scale = scale_slider.val
    x = x_slider.val
    y = y_slider.val
    
    # Update the image on the impedance plane
    ax1.clear()
    ax1.set_title('Impedance Plane')
    ax1.imshow(image, extent=[x - scale, x + scale, y - scale, y + scale])
    
    # Create a grid for the Smith chart transformation
    x_vals = np.linspace(x - scale, x + scale, 100)
    y_vals = np.linspace(y - scale, y + scale, 100)
    X, Y = np.meshgrid(x_vals, y_vals)
    Z = X + 1j * Y
    
    # Apply Smith chart transformation
    S = smith_chart_transform(Z)
    
    # Update the Smith chart
    ax2.clear()
    ax2.set_title('Smith Chart')
    ax2.set_xlim(-1, 1)
    ax2.set_ylim(-1, 1)
    ax2.grid(True)
    ax2.imshow(np.abs(S), extent=[-1, 1, -1, 1], cmap='hsv', alpha=0.6)
    
    fig.canvas.draw_idle()

scale_slider.on_changed(update)
x_slider.on_changed(update)
y_slider.on_changed(update)

# Reset button
resetax = plt.axes([0.8, 0.025, 0.1, 0.04])
button = Button(resetax, 'Reset', color=axcolor, hovercolor='0.975')

def reset(event):
    scale_slider.reset()
    x_slider.reset()
    y_slider.reset()
button.on_clicked(reset)

plt.show()
