# Milestone-Based Crowdfunding Smart Contract

## Introduction
The Milestone-Based Crowdfunding Smart Contract is a decentralized application built on the Aptos blockchain that enables secure and transparent fundraising with milestone-based fund releases. This innovative approach ensures that project funds are released gradually based on achieved milestones, providing better security for investors and accountability for project creators.

## Project Overview
The smart contract implements a crowdfunding system where:
- Project creators can initialize fundraising campaigns with specific targets
- Funds are locked in the smart contract
- Two predefined milestones control the release of funds
- Only project owners can request milestone releases
- Automatic verification of milestone conditions before fund release

### Key Features
- **Secure Fund Management**: All funds are securely stored in the smart contract
- **Milestone-Based Releases**: Two-stage milestone system for gradual fund release
- **Permission Control**: Only authorized project owners can release milestone funds
- **Balance Verification**: Automatic checking of sufficient funds before releases

## Vision
The vision of this project is to revolutionize crowdfunding by introducing accountability and transparency through blockchain technology. By implementing milestone-based fund releases, we aim to:
1. Reduce investment risks in crowdfunding projects
2. Ensure project accountability
3. Create a trustless environment for fundraising
4. Promote successful project completion
5. Build investor confidence in crowdfunding platforms

## Future Goals
Our roadmap includes several planned enhancements:

### Short-term Goals
- Add support for dynamic milestone creation
- Implement voting mechanism for milestone approval
- Create events for better tracking of contract activities
- Add time-based milestone locks

### Medium-term Goals
- Develop a frontend interface for easy interaction
- Integrate multiple token support beyond AptosCoin
- Add project updates and reporting functionality
- Implement milestone verification oracles

### Long-term Goals
- Create a DAO governance system for project oversight
- Develop cross-chain crowdfunding capabilities
- Implement AI-based project success prediction
- Build a reputation system for project creators

## Deployment Information
- **Network**: Aptos Devnet
- **Contract Address**: `0xa12605d185ceeaa7d8c888fdc435d16b856adfb41e26734331cc4796ebd9ecf3`
- **Module Name**: `milestone_crowdfunding`
- **Module Path**: `aptos_crowdfunding::milestone_crowdfunding`

## How to Use
1. Initialize a project:
```bash
aptos move run --function-id 'address::milestone_crowdfunding::initialize_project' \
    --args 'u64:target_amount' 'u64:milestone1_amount' 'u64:milestone2_amount'
```

2. Release milestone funds:
```bash
aptos move run --function-id 'address::milestone_crowdfunding::release_milestone' \
    --args 'u64:milestone_number'
```

## Security Considerations
- Only project owners can release milestone funds
- Automatic balance verification before releases
- Built-in permission checks
- Milestone release status tracking

## Contributing
We welcome contributions! Please feel free to submit pull requests or create issues for any bugs or feature requests.

## License
This project is licensed under the MIT License - see the LICENSE file for details.
