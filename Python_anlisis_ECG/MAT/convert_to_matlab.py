import neo
import scipy.io
import matplotlib.pyplot as plt
import numpy as np
from quantities import mV, ms
from scipy.signal import find_peaks
import sys

# Obtener argumentos desde la línea de comandos
folder_spike = sys.argv[1]
file_name_spike = sys.argv[2]
folder_matlab = sys.argv[3]
file_name_matlab = sys.argv[4]


# Read the SMR file
reader = neo.Spike2IO(filename=folder_spike+'/'+file_name_spike+'.smr')
data = reader.read()[0]

# Extract the signal you want to plot
signal = data.segments[0].analogsignals[0]

# Convertir el objeto AnalogSignal a un formato que pueda ser guardado
signal_array = signal.magnitude  # Magnitud en unidades base (por ejemplo, mV)
sampling_rate = signal.sampling_rate.magnitude  # Frecuencia de muestreo

scipy.io.savemat(folder_matlab+'/'+file_name_matlab+'.mat', {'signal': signal_array, 'sampling_rate': sampling_rate})
