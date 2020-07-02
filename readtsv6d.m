function q = readtsv6d(fn)
% Reads files in .tsv format recorded with QTM. 6DOF activated.
% Timevec should be included in export TSV
% Works only for 1 body so far!!!!
%
% input parameters
% fn: File name; tsv format (norm data structure)
% 
% output
% q: structure
% Data to analyse
% q.time : [s] timevec
% q.data6D = X Y Z Roll Pitch Yaw  size(q.dataglob)=[q.frames x 6]
%             -> XYZ converted to m, angles in degrees.


%
% From the Motion Capture Toolbox, Copyright 2008, 
% University of Jyvaskyla, Finland, original file: mcreademg.m


ifp = fopen(fn);
if ifp<0
    disp(['Could not open file ' fn]);
    [y,fs] = audioread('mcsound.wav');
    sound(y,fs);
    return;
end

q.filename = fn;

s=fscanf(ifp,'%s',1); 
s=fscanf(ifp,'%s',1); q.frames = str2num(s); q.frames=str2num(s);
s=fscanf(ifp,'%s',1);
s=fscanf(ifp,'%s',1); q.cameras = str2num(s);
s=fscanf(ifp,'%s',1);
s=fscanf(ifp,'%s',1); q.bodies = str2num(s);
s=fscanf(ifp,'%s',1);
s=fscanf(ifp,'%s',1); q.freq = str2num(s);
s=fscanf(ifp,'%s',1);
s=fscanf(ifp,'%s',1); q.analog = str2num(s);
s=fscanf(ifp,'%s',1);
s=fscanf(ifp,'%s',1); q.analogfreq = str2num(s);
s=fscanf(ifp,'%s',1);
s=fgetl(ifp); q.description = s;
s=fgetl(ifp); q.timeStamp=s;
s=fgetl(ifp); q.datatype = s;
s=fscanf(ifp,'%s',1);
% check if event
s = textread(fn,'%s%*[^\n]') ;
ind = strmatch('EVENT',s);
q.eventsnr=length(ind);
if ind>0
    i=0;
   for i=1:length(ind)
     s=fgetl(ifp); q.event2 = s;
     word   = 'event';
     ind2 = strfind(s, word);
     q.eventframes(i) = sscanf(s(ind2(1) + length(word):end), '%g', 1);
   end
     s=fscanf(ifp,'%s',1);
end
s=fscanf(ifp,'%s',1); q.bodyname = s;


% end 20080811 fix
s=fscanf(ifp,'%s',1); % 20080811 fixed bug that prevented reading non-annotated tsv files
tmp=fgetl(ifp); % 'BODY HEADER'
q.bodyheader=cell(18,1); % 16 columns
if length(tmp)>14 % if header names given
    s=sscanf(tmp,'%s',1);
    q.bodyheader = strread(tmp,'%[^\n\r\t]');
end


tmp=textscan(ifp,'%f','delimiter','\t');
tmp2=tmp{1}; q.nData=tmp2;

% 
q.frames_check=length(tmp2)/(length(q.bodyheader)+1);

q.data_raw = reshape(tmp2',length(q.bodyheader)+1,q.frames_check)';
q.time=q.data_raw(:,2);
q.data_raw(:,3:5)=q.data_raw(:,3:5)./1000; % from [mm] to [m] 
q.data6D=q.data_raw(:,3:8);
q.residual=q.data_raw(:,9);
rotdata=q.data_raw(:,10:end);

% Reshape rotation matrixes from 1x6 to 3x3
[m,n]=size(rotdata);
q.rotmatrices=reshape(rotdata',[3,3,m]);

% Activated if trigger is used to create events in tsv file...
% ...put into readtsv6D.
if q.eventsnr ~= 0
    q.eventdata=q.data_raw(q.eventframes,:);
    q.events_xyzcoord=q.eventdata(:,3:5)
end



 fclose(ifp);

% Not validated yet: 
% % Rotate around global Z axis to local roll and pitch
% %Rx=[1 0 0; 0 cosd(phi(i)) -sind(phi(i)); 0 sind(phi(i)) cosd(phi(i))];
% %Ry=[cosd(theta(i)) 0 sind(theta(i)); 0 1 0; -sind(theta(i)) 0 cosd(theta(i))];
% for i=1:q.frames
% Rz=[cosd(q.dataglob(i,6)) -sind(q.dataglob(i,6)) 0; sind(q.dataglob(i,6)) cosd(q.dataglob(i,6)) 0; 0 0 1];
% locrot(:,i)=Rz*[q.dataglob(i,4);q.dataglob(i,5);q.dataglob(i,6)];
% q.localrot=locrot';
% end

% % Create time vec
% ttemp=0:(q.frames/q.freq)/(q.frames):q.frames/q.freq;
% if q.frames ~= length(ttemp)
% q.time=0:(q.frames/q.freq)/(q.frames-1):q.frames/q.freq;
% else
% q.time=0:(q.frames/q.freq)/(q.frames):q.frames/q.freq;
% end
% 
% 
% 
% if isempty(find(q.dataglob(:,6)>90))==0
%     q.warning=['Observe: Yaw larger than 90 deg, pitch direction is reversed.']
% end
% 
%
% 
% 
% 
