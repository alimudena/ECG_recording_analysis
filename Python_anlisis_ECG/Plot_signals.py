# Import necessary libraries
import neo
import scipy.io
import matplotlib.pyplot as plt

# Read the SMR file
name = "EXP002/raton1_est_anestesia"
reader = neo.Spike2IO(filename="Python_anlisis_ECG/02_CTB_setup_experiments/"+name+".smr")
data = reader.read()[0]

# Extract the signal you want to plot
signal = data.segments[0].analogsignals[0]
# Convertir el objeto AnalogSignal a un formato que pueda ser guardado
signal_array = signal.magnitude  # Magnitud en unidades base (por ejemplo, mV)
sampling_rate = signal.sampling_rate.magnitude  # Frecuencia de muestreo
print(signal.sampling_rate)


scipy.io.savemat("Python_anlisis_ECG/MAT/"+name+'.mat', {'signal': signal_array, 'sampling_rate': sampling_rate})
# Create a plot

plt.figure(1)
plt.plot(signal.times, signal[:, 1])
plt.xlabel('Time')
plt.ylabel('Signal B')
plt.title('SMR Data Plot')
# plt.show()



plt.figure(2)
plt.plot(signal.times, signal[:, 0])
plt.xlabel('Time')
plt.ylabel('Signal A')
plt.title('SMR Data Plot')
plt.show()