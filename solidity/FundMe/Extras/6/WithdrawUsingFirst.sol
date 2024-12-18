 
function withdrawOnlyFirstAccountRemix() public {
        // Allow only the first account in the funders array to withdraw
        require(funders.length > 0, "No funders yet");
        require(msg.sender == funders[0], "Only the first funder can withdraw");
        resetFunders();
        (bool success, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(success, "Withdrawal failed");
    }

    function resetFunders() private {
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address  
    }
