# 🤖 Robot Framework Guideline

<a name="readme-top"></a>
## Table of Contents:

- [Project Folder Structure](#project-folder-structure)
  - [Files and Folders Naming Conventions](#files-and-folders-naming-conventions)
- [Code Style](#code-style)
  - [Common Mistakes](#common-mistakes)
  - [Encapsulate Variables and Keywords in a Single File](#encapsulate-variables-and-keywords-in-a-single-file)
  - [Global Variables](#global-variables)
  - [Locator Naming](#locator-naming)
  - [Creating Custom Robot Framework Keywords](#creating-custom-robot-framework-keywords)
- [Libraries and Tooling](#libraries-and-tooling)
  - [Package Manager](#package-manager)
  - [Robot Framework Version](#robot-framework-version)
  - [Dependency Management with Poetry](#dependency-management-with-poetry)
  - [Virtual Environments](#virtual-environments)
- [Setting Up and Working with Poetry](#setting-up-and-working-with-poetry)
  - [Installation and configuration](#installation-and-configuration)
  - [ Generating dependency files](#generating-dependency-files)
  - [Activating a virtual environment](#activating-a-virtual-environment)
  - [Installing dependencies while in virtual environment mode](#installing-dependencies-while-in-virtual-environment-mode)
  - [Installing existing or resuable dependency files ](#installing-existing-or-resuable-dependency-files)
  - [Deactivating virtual environment ](#deactivating-virtual-environment)
  - [Running Packages](#running-packages)
  - [Poetry Cheatsheet ](#poetry-cheatsheet)
- [IDE - Text Editor](#ide---text-editor)
  - [Setting Python Virtual Environment for VSCode](#setting-python-virtual-environment-for-vscode)
- [Setting Up a New Robot Framework Project](#setting-up-a-new-robot-framework-project)
- [Useful Resources](#useful-resources)

## Project Folder Structure

- ``tests`` - Test Suites are organized in subfolders here. **Only** files containing **test cases** can be created with the ``.robot`` extension.
- ``resources`` - Keywords, variables and global locators are organized in subfolders here. These files should be created with ``.resource`` extension in
  order to distinguish said file from a test suite. The `resource` folder typically has one of the following sub directories:

  - ``po``- Stores **Page Objects**  which follow the [Page Object Model](https://testomat.io/blog/page-object-model-pattern-javascript-with-playwright/) pattern.If the system under test has a UI that is **website** based, you store and create resources representing those pages under this folder
  - `co` - **Component Objects** are like page objects, except that the UI under test isn't web based, for example like a desktop app, or a mobile app
  - `api` - Typically used when testing REST API systems. Contains resource files that represent components of an API under test
  - `shared` - Stores any resources that are shared across various test suites or other resources. One example of this is a file that contains global variables like `global_vars.resource`. Or we can also store a resource that sets ups up and tears down all suites like `global_suite_setup_teardown.resource`
  - **Note:** Its possible to use more than one of the previous folders in a project if the system under test supports it
- ``reports`` - Contains the reports RobotFramework generates
- ``data`` - Test Data files like ``*.csv``, ``*.json``, etc...  - are organized in subfolders.
- ``libraries`` - All files that are intented to either **create new Robot Framework keywords** or things such as **helper** or **utility** files that use other languages such as *Javascript, Python, Rust,* etc...
- Files that interact with the project on a global level such as ``.gitlab-ci.yml`` file for CI/CD, the ``.gitignore`` file for git, the ``README.md`` file for documentation and the `pyproject.toml` , `poetry.lock` files for dependencies, ``.env``, etc...
  are created and saved in the **project root folder**.
- Other folders can also be created at root level if needed, such as `bin` which can store executables needed when running the project

### Files and Folders Naming Conventions

- ``snake_case`` - **Only** snake case is used when naming folders and when naming files regardless of their extension (`*.js`, `*.go`, etc...). The only exception to this rule is when working with files that have a different standarized naming convention needed in order to work with other systems. A good example of this is the `Dockerfile` which must always be written with a capital "D". Or a `README` file which by convention is written in uppercase.

```
├── tests
├── resources
│   ├── co   <-- used when testing systems with UI that isn't web based
|   ├── po   <-- used when testing systems with UI that are web based
│   └── api   <-- used when testing APIs that lack UI
├── reports
├── libraries
├── bin
├── data
|
├── .github
├── .gitlab-ci.yml
├── .gitignore
├── pyproject.toml
├── poetry.lock
├── Dockerfile
├── .env
├── .gitlab-ci.yml
├── .pabotsuitenames
└── README.md
```

- Example of implementation

```
├── tests
│   ├── ui
│   │   ├── authentication
│   │   │   ├── sign_in.robot
│   │   │   └── sign_out.robot
│   │   ├── home
│   │   │   ├── landing.robot
│   │   │   └── animations.robot
│   │   └── user_profile
│   │       ├── profile.robot
│   │       └── groups.robot
│   ├── gui
│   │   ├── authentication
│   │   │   └── login.robot
│   │   ├── admin_panel
│   │   │   ├── user_management.robot
│   │   │   └── roles_and_permissions.robot
│   │   └── user_panel
│   │       ├── profile.robot
│   │       └── inventory.robot
│   └── api
│       ├── authentication
│       │   └── login.robot
│       ├── product
│       │   ├── product_uuid_creation.robot
│       │   └── product_crud_operations.robot
│       └── order
│           ├── order_uuid_creation.robot
│           └── order_processing.robot
├── resources
│   ├── shared
│   │   ├── global_vars.resource
│   │   └── suite_setup_teardown.resource
│   ├── co
│   │   ├── customers.resource
│   │   └── products.resource
│   ├── po
│   │   ├── customer_list.resource
│   │   └── products.resource
│   └── api
│       ├── orders.resource
│       └── products.resource
├── reports
│   ├── log.html
│   ├── output.xml
│   └── report.html
├── libraries
│   ├── keywords
│   │   ├── parser.py
│   │   ├── logger.py
│   │   └── calculator.py
│   └── utils
│       ├── python
│       │   └── helper.py
│       └── node
│           └── helper.js
├── data
│   ├── gui
│   │   ├── customers.csv
│   │   └── products.json
│   └── api
│       ├── customers.py
│       └── products.yml
├── bin
│   └── setup.sh
├── .github
│   └── workflows
│       └── ci.yml
├── .gitignore
├── pyproject.toml
├── poetry.lock
├── Dockerfile
├── .env
├── .gitlab-ci.yml
├── .pabotsuitenames
└── README.md
```

- For project examples using the structure and coding standards written in this document you can go to the [`/examples`](/examples) directory of this repository

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Code Style

- Each new RobotFramework project should adhere to the offical [RobotFramework Style Guide](https://docs.robotframework.org/docs/style_guide)
- Linting is handled by the Robot Framework Language Server VSCode extension. You can download it for free via [marketplace](https://marketplace.visualstudio.com/items?itemName=robocorp.robotframework-lsp) and view the source code [here](https://github.com/robocorp/robotframework-lsp)

### Common mistakes

- **Keywords** and **TestCases** must be in ``Title Case`` and with spaces in between. Acronyms such as **HTTP** , **SAP**, _etc.._ are **allowed** to be in all **uppercase**
- ```robot
   # GOOD 
    *** Keywords ***
    Suite Setup Keywords
    [Documentation]    A keyword for setting up a suite
    Log To Console    Setting up ${SUITE_NAME} keywords

  # GOOD 
    *** Keywords ***
    Send Request To SAP Interface
    [Documentation]    A keyword for setting up a suite
    Log To Console    Setting up ${SUITE_NAME} keywords
  ==========================================================================================================
  # BAD 
    *** Keywords ***
    suite setup keywords                                       # Test case is in all lowercase
    [Documentation]    A keyword for setting up a suite
    log to console    Setting up ${SUITE_NAME} keywords        # keyword in all lowercase

  # BAD 
    *** Keywords ***
    suitesetupkeywords                                         # words should be seperated and in Title Case
    [Documentation]    A keyword for setting up a suite
    log to console    Setting up ${SUITE_NAME} keywords        # keyword in all lowercase

  # BAD 
    *** Keywords ***
    SuiteSetupKeywords                                        # Uses Title Case but no seperation between words
    [Documentation]    A keyword for setting up a suite
    Log to Console    Setting up ${SUITE_NAME} keywords       # 't' in word "to" is not in uppercase
  ```
- **Variables** written in the `***Variables***` section must be in **uppercase** and with **underscores** that seperate each word

```robot
*** Variables ***
${BROWSER}                      chrome
${HEADLESS_MODE}                ${FALSE}                 
${LANDING_PAGE_URL}             https://www.saucedemo.com/
${INVENTORY_URL}                https://www.saucedemo.com/inventory.html

#Credentials
@{VALID_USERNAME}               standard_user
...                             locked_out_user
...                             problem_user
...                             performance_glitch_user
...                             error_user
...                             visual_user

${VALID_PASSWORD}               secret_sauce

#Locators
${USERNAME_TEXT_BOX}            //input[@id='user-name']
${PASSWORD_TEXT_BOX}            //input[@id='password']
${LOGIN_BUTTON}                 //input[@id='login-button']

```

- Variables with **small scope** should be in ``snake_case``

```robot
*** Keywords ***
Handle Extra Security Step If Present
    #    Add phone number for enhanced security page
    ${extra_security_step_phone_present}=
    ...                     Run Keyword And Return Status
    ...                     Page Should Contain
    ...                     ${EXTRA_SECURITY_STEP_PHONE_LABEL}

    IF    '${extra_security_step_phone_present}'=='TRUE'
        Click "Not Now" Link For Phone Security Step
    END

    #    Solve puzzle
    ${extra_security_step_puzzle_present}=
    ...                     Run Keyword And Return Status
    ...                     Page Should Contain
    ...                     ${EXTRA_SECURITY_STEP_PUZZLE_LABEL}

    IF    '${extra_security_step_puzzle_present}'=='TRUE'
        Manually Solve Puzzle
    END

```

### Encapsulate Variables and Keywords in a single file

- It is bad practice to keep Variables in a seperate resource file. Encapsulate all the logic **within one file**. If you have variables that need to be shared throughout multiple files then you can create a folder named `shared` and create a file such as  ``global_vars.resource`` in the ``resources`` directory for this purpose

```robot
file: product.resource

# GOOD
# All variables related to product.resource  and keywords are encapsulated in a single file
*** Variables ***
${PRODUCT_TITLE}                        //h1[@id='title']
${PRODUCT_PRICE_LABEL}                  //span[@class='a-price-whole']
${PRODUCT_BUY_NOW_BUTTON}               //input[@id='buy-now-button']
${PRODUCT_ADD_TO_CART_BUTTON}           //input[@id='add-to-cart-button']
${PRODUCT_GO_TO_CART_BUTTON}            //a[.//span[@class='nav-cart-icon nav-sprite']]
${PRODUCT_DELETE_FROM_CART_BUTTON}      //input[@value='Delete']

***Keywords***
Add Product To Cart
    ${product_title_text}=   Get Text          ${PRODUCT_TITLE}
    Log                                        ${product_title_text}
    Click Element                              ${PRODUCT_ADD_TO_CART_BUTTON}
    Click Element                              ${PRODUCT_GO_TO_CART_BUTTON}
    Verify Product Was Added To Cart           ${product_title_text}
    Log To Console                             Product Added Successfully
========================================================================================================
file: product.resource

# BAD!
# We are importing variables from a different folder
# The following variables are only intended to be used with our "Product" logic, therefore
# its better to keep those variables here within this file only

*** Settings ***
Resource    ../product_locators.resource    #BAD!:Avoid importing locators belonging to product.resource from seperate file

***Keywords***
Add Product To Cart
    ${product_title_text}   Get Text          ${PRODUCT_TITLE}
    Log                                       ${product_title_text}
    Click Element                             ${PRODUCT_ADD_TO_CART_BUTTON}
    Click Element                             ${PRODUCT_GO_TO_CART_BUTTON}
    Verify Product Was Added To Cart          ${product_title_text}
    Log To Console                            Product Added Successfully
```

### Global Variables

- Global variables  should be kept in a resource file such as `global_vars.resource` and should be stored in the `resources` directory inside a folder with the name `shared`. Global variables should **always** have the "_GLOBAL_DATATYPE_" prefix and should always be in **uppercase** with **underscores**. The data type prefix can be `STRING`, `NUMBER`, `DICT`, `LIST`, `VARIABLE`, `LOCATOR` just to name a few. You can also shorten the data type name even further as long as it is not at the expensive of its clarity, for example `STR`, `LOC`, `VAR`, `NUM`, etc...
  ```robot
  ***Variables***
  ${GLOBAL_LOC_SEARCH_RESULTS_LIST}        //*[@data-component-type='s-search-result']

  ${GLOBAL_VAR_VALID_LOGIN_EMAIL}          example@example.com  
  ${GLOBAL_VAR_VALID_LOGIN_PASSWORD}       password 

  ${GLOBAL_STR_FOO}                       foo
  ${GLOBAL_NUM_ONE}                       ${1}

  @{GLOBAL_LIST_PRODUCTS}                 samsung galaxy s23
  ...                                     jbl flip 6
  ...                                     Kingston XS2000 1TB

  &{GLOBAL_DICT_ITEMS}                    string=${GLOBAL_STR_FOO}
  ...                                     number=${GLOBAL_NUM_ONE}
  ...                                     list=@{GLOBAL_LIST_PRODUCTS}

  ```

### Locator Naming

- A good way to name locators is by **prefixing** them with a locator type that is **intuitive** and **clear** at first glance. This helps with legibiity and helps group up certain types of locators in order to keep the code a bit more organized

```robot
  *** Variables ***
${HEADER_LABEL_SIGNIN}                          Sign in

${TEXTBOX_SIGNIN_EMAIL}                         //input[@id='ap_email']
${TEXTBOX_SIGNIN_PASSWORD}                      //input[@id='ap_password']

${BUTTON_SIGNIN_CONTINUE}                       //input[@id='continue']
${BUTTON_SIGNIN_SUBMIT}                         //input[@id='signInSubmit']
${BUTTON_SIGNOUT}                               //span[normalize-space()='Sign Out']

# Security guards from site
${LABEL_EXTRA_SECURITY_STEP_PHONE}              Keep hackers out
${LABEL_EXTRA_SECURITY_STEP_PUZZLE}             Solve this puzzle to protect your account

${LINK_EXTRA_SECURITY_STEP_PHONE_NOT_NOW}       //a[@id='ap-account-fixup-phone-skip-link']

# BUG
${URL_USER_ALREADY_LOGGED_IN}                   https://www.amazon.com/gp
```

### Creating Custom Robot Framework Keywords

- In order to create a new Robot Framework keyword:

1. Create a `.py` file that matches the class name but using `snake_case`
2. Create the class within said file using `PascalCase` as per convention when working with python
3. Write the logic for your class
4. **IMPORTANT**: At the end of the file, write equivalent of the class name which is written in ``PascalCase`` as per convention, into ``snake_case`` and set it equal to the class itself. This allows us to keep our filename written with our ``snake_case`` convention and avoids any error from RobotFramework when importing the library

- Full example of class definition:

```python
file: custom_greeting.py          # file is written in snake_case

class CustomGreeting:             # class is written using PascalCase

    def __init__(self):
        """Initialize CustomGreeting library."""
        pass

    def print_custom_greeting():
        print("hello world")


custom_greeting = CustomGreeting   # IMPORTANT: needed for export and recognition by RobotFramework
```

- Importing class and using methods as Keywords within Robot Framework

```robot

*** Settings ***
Library     ../libraries/keywords/custom_greeting.py

***Test Case***
Simple Test Case
  Print Custom Greeting        # keywords are imported successfully and import files names
                               # are kept using snake_case convention

```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Libraries and Tooling

### Package Manager

- [Poetry](https://python-poetry.org/) is used as the default package manager.  It offers better dependency resolution than [PIP](https://pip.pypa.io/en/stable/), which can be useful when working with complex projects and automatically maintains and keeps track of your dependecies in a `pyproject.toml` and `poetry.lock` file, which pip does not do by default

### Robot Framework version

- [Robot Framework | Latest Release](https://github.com/robotframework/robotframework/releases/latest) - As a general rule of thumb, it is recommended to use the latest **stable** release of Robot Framework in order to utilize the latest capabilities and bug fixes that the framework offers

### Virtual Environments

- Virtual environments are useful ways of ensuring that the correct package/library versions are consistently used every time the software runs. This helps isolate software projects from potentially conflicting libraries and packages that are installed on an operating system. Virtual environments also make the life of a developer easier since the installation of resuable dependencies is very easy and straightforward. Therefore whenever working in project you **must use** virtual environments

### Dependency Management with Poetry

- Poetry uses a `pyproject.toml` and a `poetry.lock`file for dependency management. The `pyproject.toml` file specifies the dependencies and their ranges, while the `poetry.lock` file ensures that everyone installing the dependencies gets the exact same versions.
- A typical  `pyproject.toml` can look like this:

```toml
[tool.poetry]
name = "csharp-desktop-app"
version = "0.1.0"
description = ""
authors = ["Edwin Cornejo <koed.dev@gmail.com>"]
maintainers = ["Edwin Cornejo <koed.dev@gmail.com>"]
readme = "README.md"

[tool.poetry.dependencies]
python = "^3.12"
robotframework = "^7.0"
robotframework-seleniumlibrary = "^6.2.0"
robotframework-sikulilibrary = "^2.0.3"
robotframework-pabot = "^2.18.0"
robotframework-mainframe3270 = "^4.1"
numpy = "^1.26.4"
pandas = "^2.2.0"
openpyxl = "^3.1.2"
selenium = "^4.17.2"
opencv-python = "^4.9.0.80"
appium-python-client = "^3.1.1"
kitchen = "^1.2.6"
xlrd = "^2.0.1"
decorator = "^5.1.1"
async-generator = "^1.10"
docutils = "^0.20.1"
requests = "^2.31.0"

[build-system]
requires = ["poetry-core"]
build-backend = "poetry.core.masonry.api"

```

- And a `poetry.lock` like this:

```lock
[[package]]
name = "appium-python-client"
version = "3.1.1"
description = "Python client for Appium"
optional = false
python-versions = "*"
files = [
    {file = "Appium-Python-Client-3.1.1.tar.gz", hash = "sha256:c1e70d4a0a64c1e14e4693a8bd576d9489a9b722ce6be9f2e006c4ae7cb9e77e"},
]

[package.dependencies]
selenium = ">=4.12,<5.0"

[[package]]
name = "async-generator"
version = "1.10"
description = "Async generators and context managers for Python 3.5+"
optional = false
python-versions = ">=3.5"
files = [
    {file = "async_generator-1.10-py3-none-any.whl", hash = "sha256:01c7bf666359b4967d2cda0000cc2e4af16a0ae098cbffcb8472fb9e8ad6585b"},
    {file = "async_generator-1.10.tar.gz", hash = "sha256:6ebb3d106c12920aaae42ccb6f787ef5eefdcdd166ea3d628fa8476abe712144"},
]

...
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Setting Up and Working with Poetry

### Installation and configuration

- Open powershell and install the Poetry package manager (assuming you already have python installed on your system)

```
C:\Users\user> pip install poetry   
```

- 🚨 **Important:** Configure virtual environment creation to always be in the **root of a project**

```
C:\Users\user> poetry config virtualenvs.in-project true
```

- Go inside the project directory where you want to create the environment

```
C:\Users\user> cd my-project
```

### Generating dependency files

- Once you are located within your project directory, create the virtual environment folder. When running the command below poetry will prompt you to fill out info about the project, like name, version, description, authors, etc... After filling out the info, poetry will automatically create a `.venv` folder in the root of your project. Make sure you ran the `poetry config virtualenvs.in-project true` command in the installation and configuration section
- Run the `init` command for `.toml` and `.lock` file generation

```
  C:\Users\user\my-project> poetry init  
```

### Activating a virtual environment

- Poetry will use the `.venv` folder that is in the root of your project
  - The command for activating a virtual environment is `poetry shell`

    ```
    C:\Users\user\my-project> poetry shell
    ```
  - You will see something similar to this once your virtual environment has been activated. Notice the `(my-project-py3.12)` prefix

    ```
    (my-project-py3.12) C:\Users\user\my-project>
    ```

### Installing dependencies while in virtual environment mode

- After each dependency install, your `pyproject.toml` and `poetry.lock` will automatically update its contents. This is why poetry is so powerful as a dependency manager
- Run the `poetry add` command in order to add dependencies

```
   (my-project-py3.12) C:\Users\user\my-project> poetry add robot-framework
```

### Installing existing or resuable dependency files

- To share dependencies for reuse in other projects, you should include **both** `pyproject.toml` and `poetry.lock` files.
  - First we create a new virtual environment within our project root

    ```
     C:\Users\user\ecomnerce-system> poetry env use python
    ```
  - Then activate the virtual environment running the `poetry shell` command

    ```
     C:\Users\user\ecommerce-system> poetry shell
    ```
  - Then install the dependencies from the `pyproject.toml` and `poetry.lock` files

    ```
     (venv-py3.12) C:\Users\user\ecommerce-system> poetry install
    ```

### Running packages

- Use `poetry run` followed by the **package** that you wish to use. Below is an example of executing a Robot Framework test suite:

```
 (ecommerce-system-py3.12) C:\Users\user\ecommerce-system> poetry run robot -d reports login.robot
```

### Deactivating virtual environment

- Use the `exit` command in order to deactivate a poetry virtual environment:

  - Before deactivation:

  ```
   (ecommerce-system-py3.12) C:\Users\user\ecommerce-system> exit
  ```

  - After running `exit` command. Notice how there is no `(ecommerce-system-py3.12)` prefix anymore:

  ```
   C:\Users\user\ecommerce-system> 
  ```
- **Note:** virtual environment folders can be deleted and regenerated whenever needed

### Poetry Cheatsheet

#### Create a new project

```bash
poetry new <project-name>
```

#### Generate dependency files in new project

```bash
poetry init 
```

#### Add a new lib

```bash
poetry add <library>
```

#### Remove a lib

```bash
poetry remove <library>
```

#### Update a lib

```bash
poetry update <library>
```

#### Get venv path

```bash
poetry run which python
```

#### Generate venv

```bash
poetry env use python
```

#### List venv

```bash
poetry env list
```

#### Run app

```bash
poetry run python app.py
```

#### Run tests

```bash
poetry run python -m unittest discover
```

#### Show dependencies

```bash
poetry show
```

#### Create script

1 - Edit `pyproject.toml`:

```toml
[tool.poetry.scripts]
test = 'scripts:test'
```

2 - Create a `scripts.py` file on the root directory of your project:

```python
import subprocess

def test():
    """
    Run all unittests. Equivalent to:
    `poetry run python -u -m unittest discover`
    """
    subprocess.run(
        ['python', '-u', '-m', 'unittest', 'discover']
    )
```

3 - Run script:

```bash
poetry run test
```

#### Disable virtual environment

```bash
exit
```

#### List configuratiom

```bash
poetry config --list
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## IDE - Text Editor

- **Visual Studio Code** is the preferred text editor used when working with Robot Framework and offers  the best support for the Robot Framework Language Server which is being actively maintained
- There are other options like **Pycharm** or **Intellij** Idea from JetBrains, but the setup is a bit more cumbersome

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Setting Python Virtual Environment for VSCode

### Manual Python Interpreter Selection

- You must choose the python interpreter for your VSCode project workspace in order for VSCode to recognize the packages installed in your virtual environment:
  - Press `ctrl + shift + p` to open the VSCode **Command Palette**:

    ![Open command palette](/images/command-palette.png)
  - Then type **"Python: Select Interpreter"** and press enter:

    ![Type select interpreter command](/images/select-interpreters-command.png)
  - Finally in the dropdown, choose the python interpreter that has the name `('.venv': Poetry)` and you are done

    ![Type select interpreter command](/images/select-poetry-venv.png)
  - For more information checkout [Using Python Environments with Visual Studio Code](https://code.visualstudio.com/docs/python/environments)

### Automatic Python Interpreter Selection

- You can alternatively add the following line of code to your VSCode `settings.json` file so that your text editor can automatically detect any `.venv` folder in your project workspace and set is at the default python interpreter:

  ```
  "python.venvPath": "${workspaceFolder}/.venv",
  ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Setting Up a New Robot Framework Project

- In the  [`/project-boilerplate`](/project-boilerplate) directory of this repo you can download the project boilerplate with the project structure defined in this guideline. The The project comes with `po`, `co` and `api` folders by default but you can leave only the folders you need for your project
- There is also a `pyproject.toml` file that you can use with the most common libraries used when working with Robot Framework. You can modify the "name" and "authors" files in the `.toml` file, create a virtual environment with poetry and then run the command `poetry install` in  order to install the dependencies or you can just delete the the `pyproject.toml` file and start from scratch.
- In short, the general steps to creating a new Robot Framework project are:

1. **Generate** `pyproject.toml` and `poetry.lock` unless the files already exist
2. **Create** a virtual environment with Poetry
3. **Select** the `('.venv': Poetry)` virtual environment as your python interpreter for your VSCode project workspace
4. **Activate** Poetry virtual environment
5. **Install** the dependencies from the `pyproject.toml` with `poetry install`
6. **Setup** project folder structure

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Useful Resources

### Robot Framework

- [Robot Framework 7.0 User Guide](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html)
- [How To Write Good Test Cases with Robot Framework](https://github.com/robotframework/HowToWriteGoodTestCases/blob/master/HowToWriteGoodTestCases.rst)
- [Project Structure Example from Official Robot Framework Site](https://docs.robotframework.org/docs/examples/project_structure)
- [Page Object Model Pattern Explained](https://testomat.io/blog/page-object-model-pattern-javascript-with-playwright/)
- [Robot Framework Syntax Cheatsheet](https://robocorp.com/docs-robot-framework/languages-and-frameworks/robot-framework/cheat-sheet)
- [Source code for robot.libraries.Builtin](https://robot-framework.readthedocs.io/en/stable/_modules/robot/libraries/BuiltIn.html)
- [Robot Framework Cookbook](https://github.com/adrianyorke/robotframework-cookbook)

### Python

- [Pip](https://note.nkmk.me/en/python-pip-usage/)
- [Poetry docs](https://python-poetry.org/docs/)
- [PyPi](https://pypi.org/)

### Misc

- [Toptal .gitgnore generator](https://www.toptal.com/developers/gitignore)

<p align="right">(<a href="#readme-top">back to top</a>)</p>
