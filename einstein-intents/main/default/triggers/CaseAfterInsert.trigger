trigger CaseAfterInsert on Case (after insert) {

    Integer chunkSize = 10;
    Integer count = 1;
    Case[] chunkOfCases = new Case[] {};

    for (Integer i = 0; i < Trigger.new.size(); i++) {
        Case cs = Trigger.new[i];
        if (cs.Origin == 'Email') {
            if (i == Trigger.new.size() - 1) {
                chunkOfCases.add(cs);
                System.enqueueJob(new IntentTypeClassification(chunkOfCases));
            } else if (i < count * chunkSize) {
                chunkOfCases.add(cs);
            } else {
                System.enqueueJob(new IntentTypeClassification(chunkOfCases));
                chunkOfCases = new Case[] {};
                count++;
            }
        }
    }

}