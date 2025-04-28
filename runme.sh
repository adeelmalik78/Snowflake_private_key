LABELS=Feature1,Feature2,Feature3

for i in ${LABELS//,/ }
do
    # call your procedure/other scripts here below
    echo "$i"
    export LIQUIBASE_COMMAND_LABELS=Feature1
    # liquibase flow
done

