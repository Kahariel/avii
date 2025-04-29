import shutil
from datetime import datetime

def backup():
    timestamp = datetime.now().strftime("%Y%m%d_%H%M")
    src = "XMLProcessing/output"
    dest = f"backups/transformed_data_{timestamp}.zip"
    shutil.make_archive(dest.replace('.zip', ''), 'zip', src)
    print(f"Backup created: {dest}")

if __name__ == "__main__":
    backup()