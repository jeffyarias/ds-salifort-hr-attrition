
#!/usr/bin/env bash
set -e

# Generate folder + file tree, ignoring junk files
STRUCTURE=$(tree -I ".git|.ipynb_checkpoints|__pycache__|.DS_Store" -L 3)

python3 <<EOF
import pathlib

structure = """$STRUCTURE"""

readme = pathlib.Path("README.md").read_text()

start = "<!-- FOLDER_STRUCTURE_START -->"
end = "<!-- FOLDER_STRUCTURE_END -->"

before, _, after_section = readme.partition(start)
_, _, after = after_section.partition(end)

generated = f"{start}\n\n\`\`\`text\n{structure}\n\`\`\`\n\n{end}"

pathlib.Path("README.md").write_text(before + generated + after)
EOF
