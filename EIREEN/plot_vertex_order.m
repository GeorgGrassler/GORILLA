coordinates = load('knots.dat');
n_vertex = coordinates(1,1);
coordinates = coordinates(2:end,:);
triangles = load('triangles.dat');
n_triangles = triangles(1,1);
triangles = triangles(2:end,:);
borders = load('')

tris = [100:3:300,n_triangles-500:3:n_triangles];

figure
hold on
for t = tris
    plot(coordinates(triangles(t,:),1),coordinates(triangles(t,:),2),'k')
%    plot(coordinates(triangles(t,1),1),coordinates(triangles(t,1),2),'or','MarkerFaceColor', [1,0,0])
%    plot(coordinates(triangles(t,2),1),coordinates(triangles(t,2),2),'og','MarkerFaceColor', [0,1,0])
%    plot(coordinates(triangles(t,3),1),coordinates(triangles(t,3),2),'ob','MarkerFaceColor', [0,0,1])
end

%tris2 = [23396:23400,23529:23534];
tris2 = [23396:23400];
%[coordinates(triangles(t,:),1),coordinates(triangles(t,1),1)]

for t = tris2
    x = [coordinates(triangles(t,:),1);coordinates(triangles(t,1),1)];
    y = [coordinates(triangles(t,:),2);coordinates(triangles(t,1),2)];
    plot(x,y,'r')
end
hold off