import json
import math
import sys

def calculate_distance(city1, city2):
    return math.sqrt((city1['x'] - city2['x'])**2 + (city1['y'] - city2['y'])**2)

try:
    with open('cities.json', 'r') as f:
        original_cities = json.load(f)
    with open('route.json', 'r') as f:
        route = json.load(f)

    # Validate route contains exactly the original cities
    if sorted([c['name'] for c in original_cities]) != sorted([c['name'] for c in route]):
        print("0.0") # Invalid route
        sys.exit(0)

    total_distance = 0.0
    for i in range(len(route)):
        city1 = route[i]
        city2 = route[(i + 1) % len(route)] # Return to start
        total_distance += calculate_distance(city1, city2)

    # ALF maximizes scores. We output a massive number minus the distance so smaller distances = higher ALF scores.
    alf_score = 100000.0 - total_distance
    print(max(0.0, alf_score)) 

except Exception as e:
    print("0.0") # Failsafe
