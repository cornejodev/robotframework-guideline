from robot.libraries.BuiltIn import BuiltIn


class AmazonSuite:
    def __init__(self):
        pass

    def product_url_matcher(self, search_term):
        """
        Purpose:
        """
        try:
            # Lowercase the search term
            search_term = search_term.lower()

            # Get the SeleniumLibrary instance
            selenium_lib = BuiltIn().get_library_instance("SeleniumLibrary")

            # Find web elements based on the search term
            elements = selenium_lib.get_webelements(
                f"xpath=//a[.//span[contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), '{search_term}')]]"
            )

            print(elements)

            if "samsung" in search_term:
                # Filter elements that don't contain 'protector' or 'case'
                filtered_elements = [
                    element
                    for element in elements
                    if "protector" not in element.text.lower()
                    and "case" not in element.text.lower()
                ]
                # Return the first element from the filtered list
                return filtered_elements[0] if filtered_elements else None
            else:
                # Check if the original list is empty
                if not elements:
                    raise LookupError(
                        f"No matching elements found for search term: '{search_term}'"
                    )

                return elements[0]
        except Exception as e:
            print(f"Error in product_url_matcher: {e}")
            raise


amazon_suite = AmazonSuite  # needed for export and recognition by RobotFramework
