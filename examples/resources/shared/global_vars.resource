*** Variables ***
${GLOBAL_VAR_BROWSER}                   chrome
${GLOBAL_VAR_HEADLESS_MODE}             ${FALSE}    # Supported with robotframework-seleniumlibrary 6.2.0 and above
${GLOBAL_VAR_URL}                       https://www.amazon.com/
${GLOBAL_VAR_VALID_LOGIN_EMAIL}         <example@example.com>    # Note: Replace with your data
${GLOBAL_VAR_VALID_LOGIN_PASSWORD}      <password>    # Note: Replace with your data

# More examples
${GLOBAL_STR_FOO}                       foo
${GLOBAL_NUM_ONE}                       ${1}

@{GLOBAL_LIST_PRODUCTS}
...                                     samsung galaxy s23
...                                     jbl flip 6
...                                     Kingston XS2000 1TB

&{GLOBAL_DICT_ITEMS}
...                                     string=${GLOBAL_STR_FOO}
...                                     number=${GLOBAL_NUM_ONE}
...                                     list=@{GLOBAL_LIST_PRODUCTS}
