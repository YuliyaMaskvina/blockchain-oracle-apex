set serveroutput on

@import_apex_workspace.sql

/

WHENEVER SQLERROR EXIT SQL.SQLCODE
declare
    l_workspace_id number;

	-- command line configuration
	-- ** MODIFY WITH CAUTION - CAN BREAK/OVERWRITE OTHER APEX APPLICATIONS IF CONFIGURED WRONG **
	l_workspace_name varchar2(100) := 'BLOCKCHAIN_SCHEMA';
	l_application_id number := 502;
	l_parsing_schema varchar2(100) := 'BLOCKCHAIN_SCHEMA';
begin
    select workspace_id into l_workspace_id
      from apex_workspaces
     where upper(workspace) = upper(l_workspace_name);
    --
    apex_application_install.set_workspace_id( l_workspace_id );
    apex_application_install.set_application_id(l_application_id);
    apex_application_install.generate_offset;
    apex_application_install.set_schema( l_parsing_schema );
    apex_application_install.set_application_alias( 'F' || apex_application_install.get_application_id );
end;

/
@demo_application.sql