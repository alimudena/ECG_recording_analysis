# Import necessary libraries
import sys
!{sys.executable} -m pip install neo
!{sys.executable} -m pip install scipy
!{sys.executable} -m pip install matplotlib
!{sys.executable} -m pip install quantities
!{sys.executable} -m pip install numpy

import neo
import scipy.io
import matplotlib.pyplot as plt
import numpy as np
from quantities import mV, ms
from scipy.signal import find_peaks
import matplotlib.pyplot as plt
import numpy as np
