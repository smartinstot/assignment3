function generateReport(f_e1, f_v1, f_plot1, f_path1, f_hist1, f_eldn1, f_temp1, f_e2, f_v2, f_plot2, f_path2, f_hist2, f_eldn2, f_temp2)
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
'Things and stuff '... 
'Blah Blah']); 
add(part1,para);

add(part1,'b)');
para = Paragraph([ ... 
'Things and stuff '... 
'Blah Blah']); 
add(part1,para);

add(part1,'c)');
f = Figure(f_path1);
f.Snapshot.Height = '4in';
f.Snapshot.Width = '6in';
f.Snapshot.Caption = 'Path of Electrons in Uniform Electric Field';
add(part1,f);

add(part1,'d)');
para = Paragraph([ ... 
'Things and stuff '... 
'Blah Blah']); 
add(part1,para);

add(part1,'e)');
f = Figure(f_eldn1);
f.Snapshot.Height = '4in';
f.Snapshot.Width = '6in';
f.Snapshot.Caption = 'Electron Density';
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
'Things and stuff '... 
'Blah Blah']); 
add(part3,para);

add(part3,'c)');
para = Paragraph([ ... 
'Things and stuff '... 
'Blah Blah']); 
add(part3,para);

add(rpt,part3);

% Close the report (required)
close(rpt);
% Display the report (optional)
%rptview(rpt);
end

