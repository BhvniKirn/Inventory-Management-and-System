from flask import Flask, render_template, request, jsonify
import psycopg2

app = Flask(__name__)
# Database connection
def get_db():
    conn = psycopg2.connect(
        dbname="InventoryManagement",
        user="postgres",
        password="postgres",
        host="localhost"
    )
    return conn

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/query', methods=['POST'])
def run_query():
    query = request.json['query']
    conn = get_db()
    cur = conn.cursor()
    try:
        cur.execute(query)
        columns = [desc[0] for desc in cur.description]
        rows = cur.fetchall()
        conn.close()
        return jsonify({'columns': columns, 'rows': rows})
    except Exception as e:
        error_message = str(e)
        conn.close()
        return jsonify({'error': error_message})

if __name__ == '__main__':
    app.run(debug=True)
