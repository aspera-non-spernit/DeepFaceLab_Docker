#!/bin/bash
WORKSPACE=/home/${USER}/DeepFaceLab/workspace
rm -rf $WORKSPACE
mkdir $WORKSPACE
mkdir "$WORKSPACE/data_src"
mkdir "$WORKSPACE/data_src/aligned"
mkdir "$WORKSPACE/data_src/aligned_debug"
mkdir "$WORKSPACE/data_src/aligned_notrain"
mkdir "$WORKSPACE/data_src/seq"
mkdir "$WORKSPACE/data_src/vid"
mkdir "$WORKSPACE/data_dst"
mkdir "$WORKSPACE/data_dst/aligned"
mkdir "$WORKSPACE/data_dst/aligned_debug"
mkdir "$WORKSPACE/data_dst/aligned_notrain"
mkdir "$WORKSPACE/data_dst/seq"
mkdir "$WORKSPACE/data_dst/vid"
mkdir "$WORKSPACE/model"
#cp ./scripts/host/clear_workspace.sh $workspace/..
#cp ./scripts/host/run.sh $workspace/..
