# Import necessary libraries
import neo
import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import hilbert

# Read the SMR file
reader = neo.Spike2IO(filename='Caracterizacion_ECG_ratones/R2_ECG.smr')
data = reader.read()[0]

# Extract the signal you want to plot
signal = data.segments[0].analogsignals[0]

# Convert signal to a numpy array
signal_array = signal.as_array()[:, 1]  # Assuming the signal is in the first column

# Calculate the envelope using Hilbert transform
analytic_signal = hilbert(signal_array)
envelope = np.abs(analytic_signal)

# Create a plot
plt.figure(figsize=(12, 6))
plt.plot(signal.times, signal_array, label='Original Signal')
plt.plot(signal.times, envelope, label='Envelope', color='r')
plt.xlabel('Time')
plt.ylabel('Amplitude')
plt.title('SMR Data Plot with Envelope')
plt.legend()
plt.show()