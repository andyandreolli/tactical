from argparse import ArgumentParser
parser = ArgumentParser(description='Remove comment lines (starting with "%") from tex file.')
parser.add_argument('files', metavar=('file.tex', 'more_files.tex'), type=str, nargs='+', help='Files to be cleaned of comment lines.')
settings = parser.parse_args()

corrected = list()

for filename in settings.files:
    with open(filename, 'r') as f:
        content = f.readlines()
    for line in content:
        if not line.startswith('%'):
            corrected.append(line)
    with open(filename, 'w') as f:
        f.writelines(corrected)
