from sphinx.application import Sphinx
from sphinx.util import logging

logger = logging.getLogger(__name__)

def add_navbar(app: Sphinx, pagename: str, templatename: str, context, doctree) -> None:
    """
    Add a navbar to the context of every HTML page.
    """
    #context['navbar'] = '<div class="wy-nav-top"; id="navbar" width: 800px; height: 100px; background-color: red;">Testing</div>'
    #context['navbar'] = '<div class="wy-top" style="position: relative; z-index: 400;>Testing</div>'
    context['navbar'] = """<div id="myNavBar"></div>"""
    context['navbar_script'] = """<script defer="defer" src="/navbar/navbar.bundle.js"></script>"""
    
    
    
    """
    <nav class="navbar">
      <ul>
        <li>
          <div class="tool-bar-title">Bryce Keen</div>
        </li>
        <li style="margin-left: auto;">
          <a href="/" style="text-decoration: none;">
            <div class="link-container">Home</div>
          </a>
         </li>
        <li>
          <a href="../../about" style="text-decoration: none;">
            <div class="link-container">About</div>
          </a>
        </li>
        <li>
          <a href="/contact" style="text-decoration: none;">
            <div class="link-container">Contact</div>
          </a>
        </li>
      </ul>
    </nav>
    """
    
    
    """
    <div id="navbar" style="height: 30px; width: 100%; background-color: red; z-index: 400; position: fixed; top: 0;">Test</div>
    """

    logger.debug('Added navbar to HTML context.')

def setup(app: Sphinx) -> dict:
    """
    Set up the Sphinx extension.
    """
    app.connect('html-page-context', add_navbar)
    logger.debug('Registered html-page-context event listener.')
    return {'version': '0.1'}
