function ax = createAxes(fignum)
%CREATEAXES Creates axes for plotting

f = figure(fignum);
clf(f,'reset')
ax = axes('Parent', f);
set(ax,'DataAspectRatio',[1 1 1])

end

