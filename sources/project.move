module Crowdfunding::milestone_Crowdfunding {
    use std::signer;
    use aptos_framework::coin;
    use aptos_framework::aptos_coin::AptosCoin;

    const ENO_MILESTONE: u64 = 0;
    const ENO_PERMISSION: u64 = 1;
    const EINSUFFICIENT_BALANCE: u64 = 2;

    struct ProjectData has key {
        owner: address,
        target_amount: u64,
        current_amount: u64,
        milestone1_amount: u64,
        milestone2_amount: u64,
        milestone1_released: bool,
        milestone2_released: bool
    }

    public entry fun initialize_project(
        account: &signer,
        target: u64,
        m1_amount: u64,
        m2_amount: u64
    ) {
        let project = ProjectData {
            owner: signer::address_of(account),
            target_amount: target,
            current_amount: 0,
            milestone1_amount: m1_amount,
            milestone2_amount: m2_amount,
            milestone1_released: false,
            milestone2_released: false
        };
        move_to(account, project);
    }

    public entry fun release_milestone(
        account: &signer,
        milestone_number: u64
    ) acquires ProjectData {
        let sender_address = signer::address_of(account);
        let project = borrow_global_mut<ProjectData>(sender_address);
        
        assert!(project.owner == sender_address, ENO_PERMISSION);
        
        if (milestone_number == 1) {
            assert!(!project.milestone1_released, ENO_MILESTONE);
            assert!(project.current_amount >= project.milestone1_amount, EINSUFFICIENT_BALANCE);
            
            coin::transfer<AptosCoin>(account, project.owner, project.milestone1_amount);
            project.milestone1_released = true;
        } else if (milestone_number == 2) {
            assert!(!project.milestone2_released, ENO_MILESTONE);
            assert!(project.current_amount >= project.milestone2_amount, EINSUFFICIENT_BALANCE);
            
            coin::transfer<AptosCoin>(account, project.owner, project.milestone2_amount);
            project.milestone2_released = true;
        };
    }
}