function generateReport(f_e1, f_v1, f_plot1, f_path1, f_hist1, f_eldn1, f_temp1, f_i1, f_e2, f_v2, f_plot2, f_path2, f_hist2, f_eldn2, f_temp2, f_i2)
%generateReport Generates a report for the assignment
% Import report API classes (optional)
import mlreportgen.report.*
import mlreportgen.dom.* 

delete assignment3meeting.pdf
delete assignment3meeting_FO

% Add report container (required)
rpt = Report('assignment3meeting','pdf');

% Add content to container (required)
% Types of content added here: title 
% page and table of contents reporters
titlepg = TitlePage;
titlepg.Title = 'ELEC 4700 Assignment 3';
titlepg.Subtitle = 'Monte-Carlo/Finite Differemce Method';
titlepg.Author = 'David Bascelli';
add(rpt,titlepg);
add(rpt,TableOfContents);

% Part 1
part1 = Chapter('Electrons in Uniform Electric Field');

add(part1,'a)');
para = Paragraph([ ... 
'If a simple uniform gradient, we can assume E=V/r'... 
'So if voltage = 0.1 V and r = 200 nm, then E= 500 kV/m']); 
add(part1,para);

add(part1,'b)');
para = Paragraph([ ... 
'F = qE, q = charge of electron = 1.60217653e-19 C, '... 
'Thus F = 8.01E-14 N']); 
add(part1,para);

add(part1,'c)');
para = Paragraph([ ... 
'a = m0/F, m0 = mass of electron = 9.10938215e-31 '... 
'Thus a = 7.2974e-44 m/s^2']); 
add(part1,para);
f = Figure(f_path1);
f.Snapshot.Height = '4in';
f.Snapshot.Width = '6in';
f.Snapshot.Caption = 'Path of Electrons in Uniform Electric Field';
add(part1,f);

add(part1,'d)');
para = Paragraph([ ... 
'With electrons moving in all directions, the drift velocity is '...
'the net movement of electrons in a certain direction. It is the ' ...
'directional average velocity. It is calculated using the '...
' formula : Vdrift = sum(V)/N, I = q*Cd*Vdrift. ' ...
'The current starts out near zero, as the inital speed is just '...
'random thermal velocity. The drift velocity then increaes as ' ...
'the electric field causes the electrons to accelerate in one direction. ' ...
'As the electron velocity reaches equalibrium then current then stabalizes' ]); 
add(part1,para);
f = Figure(f_i1);
f.Snapshot.Height = '4in';
f.Snapshot.Width = '6in';
f.Snapshot.Caption = 'Electron Current';
add(part1,f);

add(part1,'e)');
f = Figure(f_eldn1);
f.Snapshot.Height = '4in';
f.Snapshot.Width = '6in';
f.Snapshot.Caption = 'Electron Density';
add(part1,f);

f = Figure(f_temp1);
f.Snapshot.Height = '4in';
f.Snapshot.Width = '6in';
f.Snapshot.Caption = 'Electron Temperature';
add(part1,f);

add(rpt,part1);

part2 = Chapter('Calculation of Electric Field with Bottleneck');


add(part2,'a)');
f = Figure(f_v2);
f.Snapshot.Height = '4in';
f.Snapshot.Width = '6in';
f.Snapshot.Caption = 'Potential of Bottleneck';
add(part2,f);

add(part2,'b)');
f = Figure(f_e2);
f.Snapshot.Height = '4in';
f.Snapshot.Width = '6in';
f.Snapshot.Caption = 'Electric Field of Bottleneck';
add(part2,f);

add(rpt,part2);

part3 = Chapter('Electrons in Bottleneck');

add(part3,'a)');
f = Figure(f_path2);
f.Snapshot.Height = '4in';
f.Snapshot.Width = '6in';
f.Snapshot.Caption = 'Path of Electrons in Bottleneck';
add(part3,f);

add(part3,'b)');
f = Figure(f_eldn2);
f.Snapshot.Height = '4in';
f.Snapshot.Width = '6in';
f.Snapshot.Caption = 'Density of Electrons in Bottleneck';
add(part3,f);
para = Paragraph([ ... 
'Electrons are getting stuck against the right side of the block,  '... 
'this is because they are unable to escape the electric' ...
' field at that point. In the other direction, electrons are' ...
' funneled out of the gap. We have higher electron density on the' ...
'high voltage side.']); 
add(part3,para);

add(part3,'c)');
para = Paragraph([ ... 
'The obvious solution of greater accuracy is smaller grid size, '...
'smaller step time, more particles and longer run time. '...
'Another improvement would be to allow the electrons to travel '...
'through the insulating material, maybe by modeling the insulating'...
' area as having an increased mean time between collision.']); 
add(part3,para);

add(rpt,part3);

% Close the report (required)
close(rpt);
% Display the report (optional)
%rptview(rpt);
end

