#/bin/bash

set -e


if [[ -d "$PYTHON_DIR" ]]; then
  rm -rf "$PYTHON_DIR"
fi
mkdir -p "$PYTHON_DIR"
cd "$PYTHON_DIR"


pypyFile="pypy$PYTHON_VERSION-$PYPY_VERSION-linux_x86_64-portable"
tarFile="$PYTHON_DIR/$pypyFile.tar.bz2"

if [[ -e "$tarFile" ]]; then
  tar -xjf "$tarFile"
  rm -rf "$tarFile"
else
  wget -O - "https://bitbucket.org/squeaky/portable-pypy/downloads/$pypyFile.tar.bz2" | tar -xjf -
fi

mv -n "$pypyFile" pypy


mkdir -p "$PYTHON_DIR/bin/"

cat > "$PYTHON_DIR/bin/python" <<EOF
#!/bin/bash
LD_LIBRARY_PATH=$PYTHON_DIR/pypy/lib:$LD_LIBRARY_PATH exec $PYTHON_DIR/pypy/bin/pypy "\$@"
EOF

chmod +x "$PYTHON_DIR/bin/python"
"$PYTHON_DIR/bin/python" --version

cat > "/etc/profile.d/python-path.sh" <<EOF
#!/bin/bash
export PATH="$PATH:/opt/python/bin"
EOF

chmod +x /etc/profile.d/python-path.sh

touch "$PYTHON_DIR/.bootstrapped_${PYTHON_VERSION}_$PYPY_VERSION"
