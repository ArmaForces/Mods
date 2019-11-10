#!/usr/bin/env python3

import fnmatch
import os
import sys
import xml.etree.ElementTree as ET

# STRINGTABLE VALIDATOR
# Author: mharis001
# ---------------------
# Verifies all stringtable.xml files in the project. Checks for:
#   - proper XML tree structure.
#   - English as first translation.
#   - no Original translation.
#   - duplicated entries and languages.


######## GLOBALS #########
PROJECT_NAME = "AFM"
##########################


def check_stringtable(filepath):
    try:
        tree = ET.parse(filepath)
    except:
        print("  ERROR: Failed to parse file.")
        return 1

    errors = 0

    # Verify that the root tag is Project and its name attribute is the project name
    root = tree.getroot()

    if root.tag != "Project":
        print("  ERROR: Invalid root tag '{}' found, must be 'Project'.".format(root.tag))
        errors += 1

    if root.get("name") != PROJECT_NAME:
        print("  ERROR: Invalid name attribute '{}' for Project tag, must be '{}'.".format(root.get("name"), PROJECT_NAME))
        errors += 1

    # Verify that the root has a Package tag and its name attribute matches the component's folder name
    package = root.find("Package")

    if package is None:
        print("  ERROR: Failed to find 'Package' tag under 'Project' tag.")
        errors += 1
    else:
        package_name = package.get("name")

        if package_name.islower():
            print("  ERROR: Package name attribute '{}' is all lowercase, should be in titlecase.".format(package_name))
            errors += 1

        if package_name.lower() != os.path.basename(os.path.dirname(filepath)):
            print("  ERROR: Package name attribute '{}' does not match the component folder name.".format(package_name))
            errors += 1

        # Get all keys contained in the stringtable
        keys = package.findall("Key")

        for container in package.findall("Container"):
            keys.extend(container.findall("Key"))

        key_ids = []
        key_prefix = "STR_{}_{}_".format(PROJECT_NAME, package_name)

        for key in keys:
            key_id = key.get("ID")

            # Verify that the key has a valid ID attribute
            if key_id is None:
                print("  ERROR: Key '{}' had no ID attribute.".format(key_id))
                errors += 1
            elif key_id.find(key_prefix) != 0:
                print("  ERROR: Key '{}' does not have a valid ID attribute, should be in format {}{{name}}.".format(key_id, key_prefix))
                errors += 1

            key_ids.append(key_id)

            # Verify language entries for the key, check that the key:
            #   - contains at least one translation
            #   - does not contain an Original translation
            #   - has English as the first listed translation
            #   - has only one entry for each language
            entries = list(key)

            if len(entries) == 0:
                print("  ERROR: Key '{}' has no translation entries.".format(key_id))
                errors += 1
            else:
                if not key.find("Original") is None:
                    print("  ERROR: Key '{}' has an Original translation, unnecessary with English as first.".format(key_id))
                    errors += 1

                if entries[0].tag != "English":
                    print("  ERROR: Key '{}' does not have its English translation listed first.".format(key_id))
                    errors += 1

                languages = list(map(lambda l: l.tag, entries))

                for language in set(languages):
                    count = languages.count(language)

                    if count > 1:
                        print("  ERROR: Key '{}' has {} {} translations.".format(key_id, count, language))
                        errors += 1

        # Verify that key IDs are unique
        for id in set(key_ids):
            count = key_ids.count(id)

            if count > 1:
                print("  ERROR: Key '{}' is duplicated {} time(s).".format(id, count))
                errors += 1

    if errors == 0:
        print("No errors found.")
    else:
        print("Found {} error(s).".format(errors))

    return errors


def main():
    print("Validating Stringtables")
    print("-----------------------")

    # Allow running from root directory and tools directory
    root_dir = ".."
    if os.path.exists("addons"):
        root_dir = "."

    # Check all stringtable.xml files in the project directory
    bad_count = 0

    for root, _, files in os.walk(root_dir):
        for file in fnmatch.filter(files, "stringtable.xml"):
            filepath = os.path.join(root, file)

            print("\nChecking {}:".format(os.path.relpath(filepath, root_dir)))

            bad_count += check_stringtable(filepath)

    print()

    if bad_count == 0:
        print("Stringtable Validation PASSED")
    else:
        print("Stringtable Validation FAILED")

    return bad_count


if __name__ == '__main__':
    sys.exit(main())
