#########################################################################
# Verisium Debug version 24.09.001-s (Built on 2024-09-26T16:03:08Z)
# history.py generated at 2026/05/04 19:09:41
# host: vm-linux01
# port: 38453
# launch command: indago -connect dc:vm-linux01.eecs.tufts.edu:57443 -interactive
# #########################################################################
import time, os, sys
if 'self' not in globals():
    from verisium import *
    from verisium.embedded.embedded_utils import indago_help
    self = VerisiumDebugServer(VerisiumDebugArgs(
        is_gui=True,
        is_launch_needed=True,
        port=38453,
        extra_args='-connect dc:vm-linux01.eecs.tufts.edu:57443 -interactive'
    ))

# Verisium: Attempting to connect to Verisium server on host: localhost, port: 38453
# Verisium: **************************************************************************************
# Verisium: *****                        Verisium version 24.09.001-s                        *****
# Verisium: *****                 NOTE: Some API features are Beta quality.                  *****
# Verisium: *****            Consult the <a href="api_reference/beta_apis.html" style="">API documentation</a> for more information.             *****
# Verisium: **************************************************************************************
# # Hint: Use 'self' to reference the running Verisium Debug server. (ex: self.server_info)
# >>> 