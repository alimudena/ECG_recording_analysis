
sessionData.date  = datetime(2026,2,8);
sessionData.type  = 'aVNS';
sessionData.stim  = [10 20; 40 50];   % inicio-fin
sessionData.rest  = [20 40];
sessionData.notes = 'Animal inquieto al inicio';
sessionData.sessionIdx = '01';
Database = addSession(Database,'mouse01',true,sessionData);