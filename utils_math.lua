function non_negative(number)
    return math.max(0, number)
end

function distance(point1, point2)
    return math.sqrt((point1[1] - point2[1]) ^ 2 + (point1[2] - point2[2]) ^ 2)
end

function point_inside_rectangle(point, rectangle)
    return
        point[1] >= rectangle[1] and
        point[1] <= (rectangle[1] + rectangle[3]) and
        point[2] >= rectangle[2] and
        point[2] <= (rectangle[2] + rectangle[4])
end
