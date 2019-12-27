

import-module microsoft.online.sharepoint.powershell
 
#Connect-SPOService -Url https://etr56-admin.sharepoint.com
 
$AllSites = Get-SPOSite -Limit All
 
$AllAppliedDesigns = @()
 
$AllSites | Foreach-Object{
    $siteDesignRuns = Get-SPOSiteDesignRun -WebUrl $_.Url
     
    if($siteDesignRuns){
        Write-Host $_.Url -ForegroundColor Green
        Write-Host $siteDesignRuns.Count
        Write-Host $siteDesignRuns.sitedesignid
 
        foreach($siteDesign in $siteDesignRuns)
        {
             
            $SingleAppliedDesign = New-Object PSObject -Property @{
                SiteDesignID       = $siteDesign.SiteDesignID
                SiteUrl             = $_.Url
            }
 
            $AllAppliedDesigns+=$SingleAppliedDesign
        }
    }
}
 
Write-host $AllAppliedDesigns.count
 
$AllAppliedDesigns | sort SiteDesignID
