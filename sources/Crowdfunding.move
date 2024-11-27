module 0x42::crowdfunding {
    use std::signer;
    use std::vector;
    use aptos_std::event;
    use aptos_std::table::{Self, Table};

    // Rest of your existing code remains the same


    // Errors
    const E_NOT_INITIALIZED: u64 = 1;
    const E_CAMPAIGN_NOT_FOUND: u64 = 2;
    const E_CAMPAIGN_ALREADY_EXISTS: u64 = 3;
    const E_CAMPAIGN_INACTIVE: u64 = 4;
    const E_INSUFFICIENT_FUNDS: u64 = 5;

    // Campaign structure
    struct Campaign has store, drop {
        creator: address,
        goal_amount: u64,
        current_amount: u64,
        active: bool,
        contributors: vector<address>,
    }

    // Global storage for campaigns
    struct CrowdfundingPlatform has key {
        campaigns: Table<address, Campaign>,
        create_campaign_events: event::EventHandle<CreateCampaignEvent>,
        contribute_events: event::EventHandle<ContributeEvent>,
    }

    // Events
    struct CreateCampaignEvent has drop, store {
        creator: address,
        goal_amount: u64,
    }

    struct ContributeEvent has drop, store {
        contributor: address,
        campaign_creator: address,
        amount: u64,
    }

    // Initialize the crowdfunding platform
    public fun initialize(account: &signer) {
        let platform = CrowdfundingPlatform {
            campaigns: table::new(),
            create_campaign_events: event::new_event_handle<CreateCampaignEvent>(account),
            contribute_events: event::new_event_handle<ContributeEvent>(account),
        };
        move_to(account, platform);
    }

    // Create a new campaign
    public entry fun create_campaign(
        creator: &signer, 
        goal_amount: u64
    ) acquires CrowdfundingPlatform {
        let creator_addr = signer::address_of(creator);
        
        // Ensure platform is initialized
        assert!(exists<CrowdfundingPlatform>(creator_addr), E_NOT_INITIALIZED);
        
        let platform = borrow_global_mut<CrowdfundingPlatform>(creator_addr);
        
        // Ensure campaign doesn't already exist
        assert!(!table::contains(&platform.campaigns, creator_addr), E_CAMPAIGN_ALREADY_EXISTS);
        
        // Create new campaign
        let new_campaign = Campaign {
            creator: creator_addr,
            goal_amount,
            current_amount: 0,
            active: true,
            contributors: vector::empty(),
        };
        
        // Add campaign to platform
        table::add(&mut platform.campaigns, creator_addr, new_campaign);
        
        // Emit event
        event::emit_event(&mut platform.create_campaign_events, 
            CreateCampaignEvent { 
                creator: creator_addr, 
                goal_amount 
            }
        );
    }

    // Contribute to a campaign
    public entry fun contribute(
        contributor: &signer, 
        campaign_creator: address, 
        amount: u64
    ) acquires CrowdfundingPlatform {
        let contributor_addr = signer::address_of(contributor);
        
        // Ensure platform is initialized
        assert!(exists<CrowdfundingPlatform>(campaign_creator), E_NOT_INITIALIZED);
        
        let platform = borrow_global_mut<CrowdfundingPlatform>(campaign_creator);
        
        // Ensure campaign exists
        assert!(table::contains(&platform.campaigns, campaign_creator), E_CAMPAIGN_NOT_FOUND);
        
        let campaign = table::borrow_mut(&mut platform.campaigns, campaign_creator);
        
        // Check campaign is active
        assert!(campaign.active, E_CAMPAIGN_INACTIVE);
        
        // Update campaign details
        campaign.current_amount = campaign.current_amount + amount;        vector::push_back(&mut campaign.contributors, contributor_addr);
        
        // Emit contribution event
        event::emit_event(&mut platform.contribute_events, 
            ContributeEvent { 
                contributor: contributor_addr, 
                campaign_creator, 
                amount 
            }
        );
        
        // Optional: Check if goal is reached and close campaign
        if (campaign.current_amount >= campaign.goal_amount) {
            campaign.active = false;
        }
    }

    // View campaign details
    public fun view_campaign(campaign_creator: address): Campaign acquires CrowdfundingPlatform {
        assert!(exists<CrowdfundingPlatform>(campaign_creator), E_NOT_INITIALIZED);
        
        let platform = borrow_global<CrowdfundingPlatform>(campaign_creator);
        
        assert!(table::contains(&platform.campaigns, campaign_creator), E_CAMPAIGN_NOT_FOUND);
        
        *table::borrow(&platform.campaigns, campaign_creator)
    }

    // Unit tests
    #[test_only]
    use std::unit_test;

    #[test(creator = @0x1)]
    fun test_create_and_contribute_campaign(creator: &signer) acquires CrowdfundingPlatform {
        // Initialize platform
        initialize(creator);
        
        // Create campaign
        create_campaign(creator, 1000);
        
        // View campaign
        let campaign = view_campaign(signer::address_of(creator));
        assert!(campaign.goal_amount == 1000, 1);
        assert!(campaign.active == true, 2);
    }
}