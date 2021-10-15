#!/usr/bin/env bash

if which postman >/dev/null; then
    echo "postman already installed at $(which postman), see 'snap help refresh'" >&2;
else
    sudo snap install postman >/dev/null;
    echo "Finished installing postman..." >&2;
fi

exit 0;
