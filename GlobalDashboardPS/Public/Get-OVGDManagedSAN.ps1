function Get-OVGDManagedSAN {
    <#
        .SYNOPSIS
            Retrieves the Managed SANs connected to the Global Dashboard instance
        .DESCRIPTION
            This function will retrieve the Managed SANs on the specified Global Dashboard instance
        .NOTES
            Info
            Author : Rudi Martinsen / Intility AS
            Date : 24/04-2019
            Version : 0.4.0
            Revised : 25/04-2019
            Changelog:
            0.4.0 -- Reworked output
            0.3.0 -- Changed Entity parameter to Id
            0.2.0 -- Added support for querying, changed warning text when result is bigger than count
        .LINK
            https://github.com/rumart/GlobalDashboardPS
        .LINK
            https://developer.hpe.com/blog/accessing-the-hpe-oneview-global-dashboard-api
        .LINK
            https://rudimartinsen.com/2019/04/23/hpe-oneview-global-dashboard-powershell-module/
        .PARAMETER Server
            The Global Dashboard to retrieve Managed SANs from
        .PARAMETER Id
            The Id of the Managed SAN to retrieve
        .PARAMETER Name
            Filter on the Name of the Managed SAN to retrieve. Note that we search for an exact match
        .PARAMETER SANType
            Filter on the SAN Type of the Managed SAN to retrieve. Note that we search for an exact match
        .PARAMETER State
            Filter on the State of the Managed SAN to retrieve. Note that we search for an exact match
        .PARAMETER Status
            Filter on the Status of the Managed SAN to retrieve. Note that we search for an exact match
        .PARAMETER UserQuery
            Query string used for full text search
        .PARAMETER Count
            The count of Managed SANs to retrieve, defaults to 25
        .EXAMPLE
            PS C:\> Get-OVGDManagedSAN

            Lists the Managed SANs on the connected Global Dashboard instance
        .EXAMPLE
            PS C:\> Get-OVGDManagedSAN -Id xxxxxxxx-xxxx-xxxx-xxxx-54e195f27f36

            Lists the Managed SAN on the connected Global Dashboard instance with the specified Id
        .EXAMPLE
            PS C:\> Get-OVGDManagedSAN -State Configured

            Lists the Managed SAN on the connected Global Dashboard instance with the state of Configured
    #>
    [CmdletBinding(DefaultParameterSetName="Default")]
    param (
        [Parameter(ParameterSetName="Default")]
        [Parameter(ParameterSetName="Id")]
        [Parameter(ParameterSetName="Query")]
        $Server = $Global:OVGDPSServer,
        [Parameter(ParameterSetName="Id")]
        [alias("Entity")]
        $Id,
        [Parameter(ParameterSetName="Query")]
        $Name,
        [Parameter(ParameterSetName="Query")]
        [ValidateSet("Fabric","Flat SAN")]
        $SANType,
        [Parameter(ParameterSetName="Query")]
        [ValidateSet("OK","Warning","Critical","Disabled","Unknown")]
        $Status,
        [Parameter(ParameterSetName="Query")]
        [ValidateSet("ConfigurationPending", "Configured", "Configuring", "Deleting", "Discovered", "Managed", "Removing")]
        $State,
        [Parameter(ParameterSetName="Query")]
        $UserQuery,
        [Parameter(ParameterSetName="Default")]
        [Parameter(ParameterSetName="Query")]
        $Count = 25
    )

    begin {
        $ResourceType = "managed-sans"
    }

    process {
        $Resource = BuildPath -Resource $ResourceType -Entity $Id
        $Query = "count=$Count"
        $searchFilters = @()
        $txtSearchFilters = @()

        if($Name){
            $searchFilters += 'name EQ "' + $Name + '"'
        }
        
        if($SANType){
            $searchFilters += 'sanType EQ "' + $SANType + '"'
        }

        if($Status){
            $searchFilters += 'status EQ "' + $Status + '"'
        }

        if($State){
            $searchFilters += 'state EQ "' + $State + '"'
        }

        if($UserQuery){
            $txtSearchFilters += "$UserQuery"
        }

        if($searchFilters){
            $filterQry = $searchFilters -join " AND "
            $Query += '&query="' + $filterQry + '"'
        }

        if($txtSearchFilters){
            $filterQry = $txtSearchFilters -join " AND "
            $Query += '&userQuery="' + $filterQry + '"'
        }

        
        $result = Invoke-OVGDRequest -Resource $Resource -Query $Query

        Write-Verbose "Got $($result.count) number of results"

        if ($result.Count -lt $result.Total ) {
            Write-Warning "The result has been paged. Total number of results is: $($result.total)"
        }
        
        if($result.Count -ge 1){
            Write-Verbose "Found $($result.total) number of results"
            $output = $result.members
        }
        elseif($result.Count -eq 0){
            return $null
        }
        elseif($result.category -eq $ResourceType){
            $output = $result
        }
        else{
            return $result
        }

        if($Output){
            $output = Add-OVGDTypeName -TypeName "GlobalDashboardPS.OVGDManagedSAN" -Object $output
            return $output
        }
    }

    end {
    }
}