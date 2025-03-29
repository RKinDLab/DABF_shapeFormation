function vertices = desiredShapeCoordinate(n, radius)
    % desiredShapeCoordinate returns the coordinates of the vertices of a regular polygon
    % inscribed in a circle of the specified radius, with n vertices.
    %
    % Input:
    %   n - the number of vertices of the polygon (an integer)
    %   radius - the radius of the circle in which the polygon is inscribed
    %
    % Output:
    %   vertices - an n x 2 matrix, where each row contains the (x, y)
    %              coordinates of a vertex.

    if n < 3
        error('A polygon must have at least 3 vertices.');
    end

    % Generate angles evenly spaced around a circle
    theta = linspace(0, 2*pi, n+1);  % +1 to close the polygon (first point is repeated)

    % Calculate the (x, y) coordinates using the specified radius
    x = radius * cos(theta(1:end-1));  % Remove last duplicate point
    y = radius * sin(theta(1:end-1));  % Remove last duplicate point

    % Combine the x and y coordinates into a matrix of vertices
    vertices = [x(:), y(:)]';
end
