import json
import math

# THE AGENT WILL MODIFY THIS FILE TO FIND BETTER ROUTES

def calculate_distance(city1, city2):
    return math.sqrt((city1['x'] - city2['x'])**2 + (city1['y'] - city2['y'])**2)

def solve_tsp(cities):
    # Initial naive approach: Just visit them in order
    return cities

if __name__ == "__main__":
    with open('cities.json', 'r') as f:
        cities = json.load(f)
    route = solve_tsp(cities)
    
    with open('route.json', 'w') as f:
        json.dump(route, f)
