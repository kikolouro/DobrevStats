import yaml
from yaml.loader import SafeLoader
import json
# Open the file and load the file
with open('config.yml') as f:
    data = yaml.load(f, Loader=SafeLoader)

listener = data[0]

print(listener["value1"])