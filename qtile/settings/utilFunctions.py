import os

def incBrightness():
    os.system("brightnessctl s +5%")

def decBrightness():
    os.system("brightnessctl s 5%-")
