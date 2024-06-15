import os
import json

def create_file_json(directory='/Users/mcessid/Documents/GitHub/prayer_time/lib'):
    file_data = {}

    for root, _, files in os.walk(directory):
        for file in files:
            file_path = os.path.join(root, file)
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                file_content = f.read()
            file_data[file] = file_content

    with open('files.json', 'w', encoding='utf-8') as json_file:
        json.dump(file_data, json_file, ensure_ascii=False, indent=4)

if __name__ == "__main__":
    create_file_json()
