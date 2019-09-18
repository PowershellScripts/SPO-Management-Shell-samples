$cred = Get-Credential -UserName ana@etr56.onmicrosoft.com -Message "Enter password"
Connect-SPOService -Url "https://etr56-admin.sharepoint.com" -Credential $cred
$CSVPath = "C:\Users\Public\siteoutcomes.csv"

$sites = ("https://etr56.sharepoint.com/sites/sitedesign44","https://etr56.sharepoint.com/sites/sitedesign45")

foreach ($site in $sites)
{ 

$outcomes = Invoke-SPOSiteDesign -Identity 6e7dbb3b-3657-4cbb-881c-bb2ba959719a   -WebUrl $site 

    foreach($outcome in $outcomes)
    {
        if($outcome.Outcome -eq "Failure")
        {
            Write-Host $site $outcome.Title  # $outcome.OutcomeText

            [pscustomobject]@{
                Site = $site
                FailedAction = $outcome.Title
                Reason = $outcome.OutcomeText
                } | Export-Csv -Path $CSVPath -Append
        }
    }

}
