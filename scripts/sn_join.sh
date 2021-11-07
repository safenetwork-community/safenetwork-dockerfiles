#!/bin/sh

safe networks check
safe networks switch $1
safe node join
