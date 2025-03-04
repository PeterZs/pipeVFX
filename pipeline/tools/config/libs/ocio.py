# =================================================================================
#    This file is part of pipeVFX.
#
#    pipeVFX is a software system initally authored back in 2006 and currently 
#    developed by Roberto Hradec - https://bitbucket.org/robertohradec/pipevfx
#
#    pipeVFX is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Lesser General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    pipeVFX is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Lesser General Public License for more details.
#
#    You should have received a copy of the GNU Lesser General Public License
#    along with pipeVFX.  If not, see <http://www.gnu.org/licenses/>.
# =================================================================================


class ocio(baseLib):
    def environ(self):
        # OCIO needs a config file, so we set it her for now. 
        # we have a default one in the central tools/ocio folder,
        # but we can override it jobs/shots/users!l /

        # for now, we only need it in gaffer!
        if self.parent in ['gaffer','natron']:
            for each in self.toolsPaths():        
                ocioConfig = '%s/ocio/config.ocio' % each
            self['OCIO'] = ocioConfig

