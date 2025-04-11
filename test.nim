import stl/map
import util/pair

var test_pair : pair[int, int]
test_pair.first = 1;
test_pair.second = 1;

var test_map : map[int, int]
test_map.addElement(test_pair)
test_pair.first = 2;
test_pair.second = 5;
test_map.addElement(test_pair)
test_pair.first = 3;
test_pair.second = 3;
test_map.addElement(test_pair)
echo getElementByVal(test_map, 1)