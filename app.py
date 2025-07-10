from flask import Flask, request, jsonify
import subprocess
import os  # Add this import at the top

app = Flask(__name__)
FOMA_FILE = 'morph_shk.fst'  # Use the actual compiled binary file you have

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

# Add this debug endpoint here
@app.route('/debug-files', methods=['GET'])
def debug_files():
    files = os.listdir('.')  # list files in current working directory
    return jsonify({'files': files})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
