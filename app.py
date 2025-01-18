from flask import Flask, request, jsonify, render_template
from health_utils import calculate_bmi, calculate_bmr
from dotenv import load_dotenv  # type: ignore
import os

load_dotenv()  # Load environment variables

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/bmi', methods=['POST'])
def bmi():
    try:
        data = request.get_json()
        height = float(data['height'])  # height in meters
        weight = float(data['weight'])  # weight in kg

        if height <= 0 or weight <= 0:
            return jsonify({'error': 'Height and weight must be positive numbers'}), 400

        bmi_value = calculate_bmi(height, weight)

        return jsonify({
            'bmi': round(bmi_value, 2),
            'category': get_bmi_category(bmi_value)
        })
    except (KeyError, ValueError) as e:
        return jsonify({'error': f'Invalid input: {str(e)}'}), 400
    except Exception as e:
        return jsonify({'error': f'An unexpected error occurred: {str(e)}'}), 500

@app.route('/bmr', methods=['POST'])
def bmr():
    try:
        data = request.get_json()
        height = float(data['height'])  # height in cm
        weight = float(data['weight'])  # weight in kg
        age = int(data['age'])         # age in years
        gender = data['gender'].lower()  # 'male' or 'female'

        # Validation
        if height <= 0 or weight <= 0 or age <= 0:
            return jsonify({'error': 'Height, weight, and age must be positive numbers'}), 400
        if gender not in ['male', 'female']:
            return jsonify({'error': 'Gender must be either "male" or "female"'}), 400

        bmr_value = calculate_bmr(height, weight, age, gender)

        # Daily calorie needs based on activity level
        daily_calories = {
            'sedentary': round(bmr_value * 1.2, 2),
            'light_exercise': round(bmr_value * 1.375, 2),
            'moderate_exercise': round(bmr_value * 1.55, 2),
            'heavy_exercise': round(bmr_value * 1.725, 2),
        }

        return jsonify({
            'bmr': round(bmr_value, 2),
            'daily_calories': daily_calories
        })
    except (KeyError, ValueError) as e:
        return jsonify({'error': f'Invalid input: {str(e)}'}), 400
    except Exception as e:
        return jsonify({'error': f'An unexpected error occurred: {str(e)}'}), 500

def get_bmi_category(bmi):
    if bmi < 18.5:
        return 'Underweight'
    elif 18.5 <= bmi < 25:
        return 'Normal weight'
    elif 25 <= bmi < 30:
        return 'Overweight'
    else:
        return 'Obese'

if __name__ == '__main__':
    app.run(
        host=os.getenv('HOST', '0.0.0.0'),
        port=int(os.getenv('PORT', 3000)),
        debug=os.getenv('FLASK_DEBUG', True)
    )
