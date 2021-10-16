#!/usr/bin/env bash

#!/usr/bin/env bash

if which tree >/dev/null; then
    echo "tree already installed at $(which tree), see 'snap help refresh'" >&2;
else
    sudo snap install tree >/dev/null;
    echo "Snap finished installing tree." >&2;
fi

exit 0;
