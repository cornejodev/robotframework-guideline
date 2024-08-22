# 🤖 Robot Framework Amazon Test Suite Demo
## How to run
### Setup
- First make sure you have ``python``, and the `poetry` package manager installed in your system.
- Create and activate a virtual environment in the root of the project with poetry.
- Install dependencies listed in `pyproject.toml` file
- **IMPORTANT**: Make sure you substitute the dummy email and password data in the ``global_vars.resource`` file located in the ``resources/shared``directory. Otherwise you wont be able to login to amazon.com and certain test cases  will fail
### Robot command examples
- **Example 1:** Running tests displaying virtual browser
```bash
robot -v GLOBAL_VAR_HEADLESS_MODE:FALSE -v GLOBAL_VAR_BROWSER:firefox -d reports  tests/ui/home_page.robot`
```
- **Example 2:** Running tests in headless mode
```bash
robot -v GLOBAL_VAR_HEADLESS_MODE:TRUE -v GLOBAL_VAR_BROWSER:headlessfirefox -d reports  tests/ui/home_page.robot
```
- **Example 3:** Using and argumentfile
```bash
robot --argumentfile args/robot_args.txt tests/ui/home_page.robot
```
### Running tests in parallel using Pabot
- With [Pabot](https://github.com/mkorpela/pabot) 2 processes can be executed per CPU core. So if you have for example, 8 CPU cores, this equals 16 processes
- **Example 1:** Using an argumentfile
```bash
pabot --testlevelsplit --processes 8 --argumentfile args/pabot_args.txt tests/ui/home_page.robot
```
- **Example 2:** Using argumentfile and generating reports in the ``/reports`` directory.
```bash
pabot --verbose --testlevelsplit --processes 8 --argumentfile args/pabot_args.txt tests/ui/home_page.robot
```
