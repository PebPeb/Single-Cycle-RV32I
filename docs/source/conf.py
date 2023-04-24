

import os
import sys
import shutil

# Delete the build directory before rebuilding the project
# Not doing this sometimes leaves artifacts in the build folder for some reason
if os.path.exists('../build'):
    print('Removing Build File')
    shutil.rmtree('../build')

sys.path.insert(0, os.path.abspath('.'))
sys.path.append(os.path.abspath('extensions'))



# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = 'Single-Cycle-RV32I'
copyright = '2023, Bryce Keen'
author = 'Bryce Keen'
release = '1.0.4'
version = release

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = [	'myst_parser',
    		    'sphinx_rtd_theme',
                'navbar']

source_suffix = {
    '.rst': 'restructuredtext',
    '.txt': 'markdown',
    '.md': 'markdown',
}

templates_path = ['_templates', '_themes/sphinx_rtd_theme_navbar/templates']
exclude_patterns = []


# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_show_sphinx = False
html_show_sourcelink = False
#html_theme = 'sphinx_rtd_theme'         # Standard Theme
html_theme = 'sphinx_rtd_theme_navbar'
html_theme_path = [os.path.abspath('_themes')]


html_static_path = ['_static', '_themes/sphinx_rtd_theme_navbar/static']


# Add css from custom theme
def setup(app):
    app.add_css_file('NavBar.css')