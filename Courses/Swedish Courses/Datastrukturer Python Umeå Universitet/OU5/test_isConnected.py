#The outcommented module import is used in test_run_entirescript, see comments on this function
#from pexpect import popen_spawn
import unittest
from isConnected import Graph_connectivity

class test_graph_connectivity(unittest.TestCase):

    # unit test setUp
    def setUp(self):
        # test cases we wish to run
        self.graph1 = {'Nod1':['Nod2'], 'Nod2':['Nod3'],
                       'Nod3':['Nod4'],'Nod4':[],'Nod5':['Nod4','Nod6'],'Nod6':['Nod7'],
                       'Nod7':['Nod5'],'Nod8':['Nod7'],'Nod9':['Nod4']}

        self.filegraph1 = 'graph_file.txt'
        self.startnodes1 = ['Nod1', 'Nod9']
        self.finalnodes1 = [[('Nod2', True), ('Nod3', True), ('Nod4', True), ('Nod5', False)], [('Nod4', True)]]

        self.graph2 = {'NodA': ['NodB'], 'NodB': ['NodC'],
                       'NodC': ['NodD'], 'NodD': [], 'NodE': ['NodD', 'NodF'], 'NodF': ['NodG'],
                       'NodG': ['NodE'], 'NodH': ['NodG'], 'NodI': ['NodD']}

        self.filegraph2 = 'graph_test.txt'
        self.startnodes2 = ['NodH', 'NodF']
        self.finalnodes2 = [ [('NodG',True)], [('NodG', True)] ]
        self.filegraph2 = 'test_graph.txt'

        self.graph3 = {}
        self.startnodes3 = []
        self.finalnodes3 = []
        self.filegraph3 = 'test_empty_graph.txt'


    def test_load_graph_integer(self):
        graph_connectivity = Graph_connectivity()
        loaded_graph = graph_connectivity.load_graph(self.filegraph1)
        self.assertEqual(loaded_graph, self.graph1)

    def test_load_graph_character(self):
        graph_connectivity = Graph_connectivity()
        loaded_graph = graph_connectivity.load_graph(self.filegraph2)
        self.assertEqual(loaded_graph, self.graph2)

    def test_load_graph_nonexistant(self):
        graph_connectivity = Graph_connectivity()

        with self.assertRaises(IOError):
            loaded_graph = graph_connectivity.load_graph('filedoesntexist.txt')

    def test_load_graph_empty(self):
        graph_connectivity = Graph_connectivity()
        loaded_graph = graph_connectivity.load_graph(self.filegraph3)
        self.assertEqual(loaded_graph, self.graph3)


    def test_bfs_integer(self):
        graph_connectivity = Graph_connectivity()

        visited, _ = graph_connectivity.bfs(self.graph1, self.startnodes1[0])

        self.assertEqual(visited[self.finalnodes1[0][0][0]], self.finalnodes1[0][0][1])
        self.assertEqual(visited[self.finalnodes1[0][1][0]], self.finalnodes1[0][1][1])
        self.assertEqual(visited[self.finalnodes1[0][2][0]], self.finalnodes1[0][2][1])
        self.assertEqual(visited[self.finalnodes1[0][3][0]], self.finalnodes1[0][3][1])

        visited, _ = graph_connectivity.bfs(self.graph1, self.startnodes1[1])

        self.assertEqual(visited[self.finalnodes1[1][0][0]], self.finalnodes1[1][0][1])

    def test_bfs_character(self):
        graph_connectivity = Graph_connectivity()
        visited, _ = graph_connectivity.bfs(self.graph2, self.startnodes2[0])

        self.assertEqual(visited[self.finalnodes2[0][0][0]], self.finalnodes2[0][0][1])
        self.assertEqual(visited[self.finalnodes2[1][0][0]], self.finalnodes2[1][0][1])

    def test_argparse(self):
        graph_connectivity = Graph_connectivity()
        args = graph_connectivity.prepare_args([self.filegraph1])
        self.assertEqual(args.graph_file , self.filegraph1)

        args = graph_connectivity.prepare_args([self.filegraph2])
        self.assertEqual(args.graph_file, self.filegraph2)

        args = graph_connectivity.prepare_args([self.filegraph3])
        self.assertEqual(args.graph_file, self.filegraph3)

    # This works on my computer but 1. pexpect is probably not installed on your computer and
    # 2. You might be running linux, and not sure if it works exactly the same.
    # So I prefer not to include this in the test program.

    # def test_run_entirescript(self):
    #     child = popen_spawn.PopenSpawn('python isConnected.py graphexample.txt', timeout=1)
    #     child.expect('Enter origin and destination \(quit to exit\): ')
    #     child.sendline('Nod1 Nod4')
    #     child.expect('Enter origin and destination \(quit to exit\): ')
    #     child.sendline('quit')

if __name__ == '__main__':
    print("Running tests for graph connectivity:")
    unittest.main()