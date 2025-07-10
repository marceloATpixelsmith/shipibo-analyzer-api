from flask import Flask, request, jsonify
import subprocess

app = Flask(__name__)
FOMA_FILE = 'morph-shk.foma'

@app.route('/analyze', methods=['POST'])
def analyze():
    word = request.json.get('word')
    if not word:
        return jsonify({'error': 'Missing word'}), 400

    try:
        result = subprocess.run(
            ['flookup', FOMA_FILE],
            input=word + '\n',
            text=True,
            capture_output=True
        )
        return jsonify({
            'input': word,
            'output': result.stdout.strip()
        })
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
