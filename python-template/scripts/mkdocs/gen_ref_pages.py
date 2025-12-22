"""Generate the code reference pages and navigation."""

from pathlib import Path
from typing import Any, cast

import mkdocs_gen_files

mgf = cast(Any, mkdocs_gen_files)

nav = mgf.Nav()

root = Path(__file__).parent.parent.parent
src = root / "src"

print(f"root:{root}")

for path in sorted(src.rglob("*.py")):
    print(f"========\npath:{path}")
    module_path = path.relative_to(src).with_suffix("")
    doc_path = path.relative_to(src).with_suffix(".md")
    full_doc_path = Path("reference", doc_path)

    parts = tuple(module_path.parts)
    print(f"parts:{parts}")

    if parts[-1] == "__init__":
        parts = parts[:-1]
    elif parts[-1] == "__main__":
        continue

    print(f"module_path:{module_path}")
    print(f"doc_path:{doc_path}")
    print(f"full_doc_path:{full_doc_path}")

    nav[parts] = doc_path.as_posix()

    with mgf.open(full_doc_path, "w") as fd:
        ident = ".".join(parts)
        fd.write(f"::: {ident}")
    mgf.set_edit_path(full_doc_path, path.relative_to(root))

print("========")
for item in nav.build_literate_nav():
    print(item)

with mgf.open("reference/SUMMARY.md", "w") as nav_file:
    nav_file.writelines(nav.build_literate_nav())
