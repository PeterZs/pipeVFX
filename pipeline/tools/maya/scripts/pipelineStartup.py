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

import os, sys
sys.path.insert( 0, "%s/lib/python%s.zip" % ( os.environ["MAYA_ROOT"], os.environ['PYTHON_VERSION_MAJOR'].replace(".","") ) )

import maya
import maya.cmds as m
from maya.mel import eval as meval

import pipe, os
import traceback
from time import time

startTime = time()

if 'DISPLAY' in os.environ:
    try:
        m.scriptEditorInfo(wh=True, hfn='/dev/stderr')
    except: pass
print 'Pipeline Startup...'

#
if 'MAYA_USE_VRAY' in os.environ:
    from glob import glob
    path = "%s/autodesk/maya%s/vray/scripts/*.mel" % (pipe.apps.vray().path(), os.environ['MAYA_VERSION'])
    for each in glob( path ):
        try:
            meval( 'source "%s";' % each )
        except: pass

# pipeline startup!
def pipeIdleStartup():
    import maya
    import maya.cmds as m
    from maya.mel import eval as meval
    import pipe, os
    import traceback

    print 'PipeIdleStartup...'
    # if we're in a job/shot, set workspace current to the
    # current user maya folder
    j = pipe.admin.job.current()
    if j:
        import maya.cmds as m
        user = j.shot.user()
        m.workspace( user.path('maya'), o=1 )

    # if user is 3d, add qube ui!
    # if os.environ['USER'] == '3d':
    #     meval('qube_addUI();')

    # force auto-load of these plugins at startup!
    plugs=[
        # 'slumMayaPlugin.py',
        'ieCore',
        'RenderMan_for_Maya',
        'OpenVDB',
        'AbcImport',
        'AbcExport',
        'gpuCache',
        'houdiniEngine',
#        '3delight_for_maya%s' % os.environ['MAYA_VERSION_MAJOR'],
    ]
    if plugs:
        for each in plugs:
            print '='*80
            print 'PIPE: auto-loading %s plugin...\n' % each
            try:
                m.loadPlugin( each )
            except:
                print "Can't load %s plugin!!" % each
                traceback.print_exc()
        print '='*80


    # re-initialize cortex menu to filter out admin ops!
    try:
        import IECore, IECoreMaya
    except:
        IECore=None
        IECoreMaya=None

    if IECore:
        def __createOp( className ) :
            fnOH = IECoreMaya.FnOpHolder.create( os.path.basename( className ), className )
            maya.cmds.select( fnOH.fullPathName() )

        def filteredOpCreationMenuDefinition() :
            menu = IECore.MenuDefinition()
            loader = IECore.ClassLoader.defaultOpLoader()
            for className in loader.classNames() :
                if not filter( lambda x: x in className, ['admin/'] ):
                    menu.append(
                        "/" + className,
                        {
                            "command" : IECore.curry( __createOp, className ),
                        }
                    )
            return menu

        menu = IECore.MenuDefinition()
        menu.append(
            "/Create Procedural",
            {
                "subMenu" : IECoreMaya.Menus.proceduralCreationMenuDefinition,
            }
        )

        menu.append(
            "/Create Op",
            {
                "subMenu" : filteredOpCreationMenuDefinition,
            }
        )


        if not m.about(batch=1):
            #delete default cortex menu!
            for each in filter( lambda x: m.menu( x, q=1, l=1)=='Cortex', m.window( "MayaWindow", query=True, menuArray=True ) ):
                m.deleteUI( each, menu=True )

            #create our custom one!
            global __cortexMenu
            __cortexMenu = IECoreMaya.createMenu( menu, "MayaWindow", "Cortex" )


    # force unload of Alembic plugins!!
    # m.unloadPlugin('AbcExport')
    # m.unloadPlugin('AbcImport')
    print 'pipeIdleStartup done: %.02f secs' % (time()-startTime)


# asset manager
def AESamDRAttr(*args):
    node = args[0]
    m.addAttr( node, ln="SAM_DR", dt="string" )
    m.setAttr( node+".SAM_DR", node.split('|')[-1], type="string" )

def AESamShaveNameAttr(*args):
    import IECore
    node = args[0]
    listAttrs = m.listAttr(node, ud=1)
    if listAttrs:
        for each in m.listAttr(node, ud=1):
            m.deleteAttr(node+"."+each)
    c = IECore.ClassLoader.defaultLoader( "IECORE_PROCEDURAL_PATHS" )
    c.refresh()
    p=c.load('shave',1)()
    data = p.parameters().getValue()
    ignoreList = ['path', 'startFrame', 'cacheFrameOffset', 'curvesType', 'traceset' ]
    for each in p.parameters().values():
        if each.name not in ignoreList:
            value = each.getValue()

            if type(value) is IECore.FloatData:
                m.addAttr( node, ln="SAM_%s" % each.name, at="double" )
                m.setAttr( node+".SAM_%s" % each.name, value.value )
            elif type(value) is IECore.IntData:
                m.addAttr( node, ln="SAM_%s" % each.name, at="long" )
                m.setAttr( node+".SAM_%s" % each.name, value.value )
            elif type(value) is IECore.BoolData:
                m.addAttr( node, ln="SAM_%s" % each.name, at="bool" )
                m.setAttr( node+".SAM_%s" % each.name, value.value )
            elif type(value) is IECore.StringData:
                m.addAttr( node, ln="SAM_%s" % each.name, dt="string" )
                if each.name == "shaveName":
                    m.setAttr( node+".SAM_%s" % each.name, node.split('|')[-1], type="string" )



sam_window = None
def loadAssetManager():
    try:
        import IECore, IECoreMaya, Asset
    except:
        IECore = None

    if IECore:
        def __publishRender() :
            __publish('render','maya')
            # import maya.cmds as m
            # #m.file()
            #
            # import IECore
            # import Gaffer
            # import GafferUI
            # import os, pipe
            # os.environ['PIPE_PUBLISH_FILTER'] = 'render/maya'
            # appLoader = IECore.ClassLoader.defaultLoader( "GAFFER_APP_PATHS" )
            # appLoader.classNames()
            # app=appLoader.load( 'opa' )()
            # app.parameters()['arguments'] = IECore.StringVectorData(['-Asset.type','render/maya','1','IECORE_ASSET_OP_PATHS'])
            # app.parameters()['op'] = 'publish'
            # app.parameters()['gui'] = 1
            # app.run()
            # hack fix for prman failling to compile shaders after running sam!
            pipe.apps.prman().expand()

            # import IECore;import Gaffer;import GafferUI;IECore.ClassLoader.defaultLoader( "GAFFER_APP_PATHS" ).load( 'opa' )().run()

        def __publish(f='particle', t='nParticles') :
            import IECore
            c = IECore.ClassLoader.defaultLoader( "GAFFER_APP_PATHS" )
            a = c.load( "sam" )()
            a.parameters()['type'] = f
            a.parameters()['buttons'] = '%s/%s' % (f,t)
            a.parameters()['action'] = 'publish'
            a.run()

            #
            # import maya.cmds as m
            # import IECore
            # import Gaffer
            # import PySide
            # import os, pipe
            # os.environ['PIPE_PUBLISH_FILTER'] = f
            # appLoader = IECore.ClassLoader.defaultLoader( "GAFFER_APP_PATHS" )
            # # appLoader.classNames()
            # app=appLoader.load( 'opa' )()
            # app.parameters()['arguments'] = IECore.StringVectorData(['-Asset.type','%s/%s' % (f,t),'1','IECORE_ASSET_OP_PATHS'])
            # app.parameters()['op'] = 'publish'
            # app.parameters()['gui'] = 1
            # app.run()



        def __gather() :
            import IECore
            c = IECore.ClassLoader.defaultLoader( "GAFFER_APP_PATHS" )
            a = c.load( "sam" )()
            a.run()

            # def sam():
            #     global _samWindow
            #     import IECore
            #     import Gaffer
            #     import GafferUI
            #     import samEditor
            #     import assetBrowser
            #     if '_samWindow' not in globals().keys():
            #         with GafferUI.Window( "SAM" ) as _samWindow:
            #                 browser = samEditor.SamEditor( Gaffer.ScriptNode() )
            #         GafferUI.EventLoop.mainEventLoop().start()
            #     _samWindow._qtWidget().resize( 1800, 800 )
            #     _samWindow.setVisible( True )
            #
            # sam()
            # global sam_window
            # import IECore
            # import Gaffer
            # import GafferUI
            # import os, pipe
            # import samEditor
            # import assetBrowser
            # scriptNode = Gaffer.ScriptNode()
            # with GafferUI.Window( "SAM" ) as sam_window  :
            #         browser = samEditor.SamEditor( scriptNode )
            # browser.pathChooser().getPath().setFromString( '/' )
            # sam_window._qtWidget().resize( 1800, 800 )
            # sam_window.setVisible( True )
            # GafferUI.EventLoop.mainEventLoop().start()



        import assetListWidget
        if not m.about(batch=1):
            menu = IECore.MenuDefinition()
            # menu.append("/Publish/Render",                 {"command" : __publishRender,"active" : True})
            # menu.append("/Publish/RenderSettings",         {"command" : lambda: __publish('renderSettings', 'maya'), "active" : True})
            # menu.append("/Publish/Camera",                 {"command" : lambda: __publish('camera', 'alembic'), "active" : True})
            # menu.append("/Publish/Lighting",               {"command" : lambda: __publish('lighting', 'maya'), "active" : True})
            # menu.append("/Publish/Rigging",                {"command" : lambda: __publish('rigging', 'maya'), "active" : True})
            # menu.append("/Publish/Shaders",                {"command" : lambda: __publish('shaders', 'maya'), "active" : True})
            # menu.append("/Publish/Model",                  {"command" : lambda: __publish('model', 'alembic'), "active" : True})
            # # menu.append("/Publish/Model/Maya",             {"command" : lambda: __publish('model', 'maya'), "active" : True})
            # menu.append("/Publish/Animation/Alembic",      {"command" : lambda: __publish('animation', 'alembic'), "active" : True})
            # menu.append("/Publish/Animation/Maya",         {"command" : lambda: __publish('animation', 'alembic'), "active" : True})
            # menu.append("/Publish/nParticle",              {"command" : lambda: __publish('particle', 'nParticles'), "active" : True})
            # # menu.append("/Publish/Rig/skeleton",         {"command" : __gather, "active" : False})
            # # menu.append("/Publish/Rig/light",            {"command" : __gather, "active" : False})
            # # menu.append("/Publish/Camera/Maya",            {"command" : lambda: __publish('camera', 'maya'), "active" : True})
            # # menu.append("/Publish/Animation/camera",     {"command" : __gather, "active" : False})
            # # menu.append("/Publish/Animation/vertex",     {"command" : __gather, "active" : False})
            # # menu.append("/Publish/Animation/skeleton",   {"command" : __gather, "active" : False})
            # # menu.append("/Publish/Animation/particles",  {"command" : __gather, "active" : False})
            # # menu.append("/Publish/Texture",              {"command" : __gather, "active" : False})
            # # for each in Asset.types():
            # #     s = each.split('/')
            # #     menu.append("/Publish/%12s/%s" % (s[0],s[1]),      {"command" : lambda: __publish(s[0], s[1]), "active" : True})

            import assetListWidget
            assetListWidget.SAMPanelUI()
            assetListWidget.SAMShelf()

            menu.append("/SAM Browser",                 {"command" : __gather, "active" : True, "description" : "Open the SAM Browser"})
            menu.append("/SAM Panel",                   {"command" : "import assetListWidget;reload(assetListWidget);assetListWidget.SAMPanelUI()", "active" : True, "description" : "Refresh and Open the SAM Panel"})
            menu.append("-----",                          {"divider" : True})
            menu.append("/Recreate SAM Shelf",          {"command" : "import assetListWidget;reload(assetListWidget);assetListWidget.SAMShelf();import pipelineStartup;reload(pipelineStartup)", "active" : True, "description" : "Delete and recreate the SAM Shelf."})
            menu.append("---",                          {"divider" : True})
            menu.append("/Publish is done now from the SAM panel.",{"active" : False, "description" : "leave the mouse over the panel for a few seconds for help!" })


            # remove if one already exists
            for each in filter( lambda x: m.menu( x, q=1, l=1)=='SAM', m.window( "MayaWindow", query=True, menuArray=True ) ):
                m.deleteUI( each, menu=True )


            #create our custom one!
            global __cortexMenu
            __cortexMenu = IECoreMaya.createMenu( menu, "MayaWindow", "SAM" )

    if float(os.environ["MAYA_VERSION"]) < 2018:
        import atomoShelfs
        if not m.about(batch=1):
            atomoShelfs.buildShelf()


    def AESamMenu(arg1, arg2):
        AEmenu = meval('global string $gAEMenuBarLayoutName;$__samAEMenu=$gAEMenuBarLayoutName')
        m.setParent( AEmenu )
        m.setParent( "AESamMenu", menu=1 )
        m.menu( "AESamMenu", edit=1, deleteAllItems=1 )
        m.menuItem( divider=1 )
        m.ls(sl=1)
        node = meval('global string $gAECurrentTab;$__samAEMenuSelected=$gAECurrentTab')
        if node:
            if m.nodeType( node ) == 'shaveHair':
                m.menuItem( l="Add SAM shave attributes", c=lambda x: AESamShaveNameAttr(node,x) )
            elif m.nodeType( node ) in ['mesh']:
                m.menuItem( l="Add SAM Dynamic Rule attribute", c=lambda x: AESamDRAttr(node,x) )

    # add SAM menu to attribute editor
    AEmenu = meval('global string $gAEMenuBarLayoutName;$__samAEMenu=$gAEMenuBarLayoutName')
    m.setParent( AEmenu )
    if "AESamMenu" not in m.menuBarLayout( AEmenu, q=1, menuArray=1 ):
        m.menu("AESamMenu", label="SAM", pmc=AESamMenu)
    m.menu("AESamMenu", e=1, pmc=AESamMenu)


    print 'loadAssetManager() done: %.02f secs' % (time()-startTime)




def RMS_setup():
    # force prman preferences using mel
    # so IPR/Render from maya uses our wrapper plugins!
    # meval('rman setPref itLaunchPath  "%s/scripts/it"' % pipe.roots().tools())
    meval('rmanChangeToRenderMan;')

    meval('rman setPref LaunchRaytraceRerenderCmd "launch:%s/prman/bin/maya_prman? "' % pipe.roots().tools())
    meval('rman setPref LaunchReyesRerenderCmd "launch:%s/prman/bin/maya_prman? "' % pipe.roots().tools())

    #meval('rman setPref LaunchStdArgs "-t:0   -Progress -ctrl \$ctrlin \$ctrlout -xcpt \$xcptin"')
    meval('rman setPref mayabatchLaunchPath "{run maya -batch}"')

    meval('rman setPref LocalRenderCmd  "%s/prman/bin/maya_prman -t:0  -Progress -recover %%r -checkpoint 0"' % pipe.roots().tools())
    meval('rman setPref RemoteRenderCmd "%s/prman/bin/maya_prman -t:0  -Progress -recover %%r -checkpoint 0"' % pipe.roots().tools())
    meval('rman setPref LocalQueueLaunchPath "%s/prman/bin/LocalQueue"' % pipe.roots().tools())
    meval('source "renderManNodes";rmanCreateGlobals')
    m.select(cl=1)
    print 'RMS_setup() done: %.02f secs' % (time()-startTime)



# m.scriptJob( runOnce=True,  idleEvent=pipeIdleStartup )
# m.scriptJob( runOnce=True,  idleEvent=loadAssetManager )
# m.scriptJob( runOnce=True,  idleEvent=RMS_setup )
if m.about(batch=1):
    pipeIdleStartup()
    loadAssetManager()
    RMS_setup()
else:
    def __runAll__():
        if float(os.environ["MAYA_VERSION"]) < 2018:
            import genericAsset
        pb = genericAsset.progressBar(3,"Finishing maya startup... ")
        pb.step()
        pipeIdleStartup()
        pb.step()
        loadAssetManager()
        pb.step()
        if float(os.environ["MAYA_VERSION"]) < 2018:
            RMS_setup()
        pb.close()
    __runAll__()
    # m.scriptJob( runOnce=True,  idleEvent=__runAll__ )
