 #!/bin/bash

function main {
  # Source the other files to gain access to their functions
  source /src/AICF-action-destroy.sh
  source /src/AICF-action.sh
  source /src/installTF.sh
  source /src/AICF-action-fugueRescan.sh

  case "${INPUT_TFCOMMAND}" in
    apply)
      sudo installTF
      sudo aicfApply ${*}
      ;;
    destroy)
      sudo installTF
      sudo aicfDestroy ${*}
      ;;
    *)
      echo -e "Error: Must provide a valid value for terraform_subcommand"
      exit 1
      ;;
  esac
}

main "${*}"
