import json
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('--path', type=str, required=True)
parser.add_argument('--domain', type=str, required=True)
args = parser.parse_args()

predicted = open(args.path + args.domain+ '_devtest_dials_predicted.txt', 'r')
predicted_processed_generation = open(args.path + "dstc9-simmc-teststd-" + args.domain + "-subtask-2-generation.json", 'w')
predicted_processed_retrieval = open(args.path + "dstc9-simmc-teststd-" + args.domain + "-subtask-2-retrieval.json", 'w')

BELIEF_STATE = " => Belief State : "
EOB = " <EOB> "

def postprocess_generation(reader, writer):
    for i, line in enumerate(reader.readlines()):
        # writer.write(str(i) + '\t')
        split = line.split(BELIEF_STATE)
        prompt = split[0]
        bs = split[-1]
        
        split = bs.split(EOB)
        state = split[0]
        response = split[-1]
        writer.write(response)

postprocess_generation(predicted, predicted_processed_generation)
# postprocess_retrieval(predicted, predicted_processed_retrieval)


